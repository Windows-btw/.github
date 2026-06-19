-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Linux (WSL/Ubuntu) Universal Polyglot Code Runner Keybinding
-- Supports: C, C++, Python, Rust, and Go
vim.keymap.set("n", "<leader>rr", function()
  -- Save the current file quietly
  vim.cmd("silent! write")

  -- Gather core filesystem strings
  local file_path = vim.fn.expand("%:p") -- Full absolute file path
  local file_dir = vim.fn.expand("%:p:h") -- Folder directory containing the code
  local file_name_no_ext = vim.fn.expand("%:t:r") -- File name without extension
  local file_ext = vim.fn.expand("%:e") -- Target extension string

  local run_command = ""

  -- 1. C / C++ Handling
  if file_ext == "cpp" or file_ext == "cc" then
    run_command = string.format(
      'cd "%s" && g++ -std=c++17 "%s" -o "%s" && ./"%s"',
      file_dir,
      file_path,
      file_name_no_ext,
      file_name_no_ext
    )
  elseif file_ext == "c" then
    run_command =
      string.format('cd "%s" && gcc "%s" -o "%s" && ./"%s"', file_dir, file_path, file_name_no_ext, file_name_no_ext)

  -- 2. Python Handling
  elseif file_ext == "py" then
    run_command = string.format('cd "%s" && python3 "%s"', file_dir, file_path)

  -- 3. Rust Handling (Checks for Cargo project, falls back to rustc)
  elseif file_ext == "rs" then
    -- If a Cargo.toml exists in the directory or parent, use 'cargo run'
    if vim.fn.filereadable(file_dir .. "/Cargo.toml") == 1 then
      run_command = string.format('cd "%s" && cargo run', file_dir)
    else
      run_command = string.format(
        'cd "%s" && rustc "%s" -o "%s" && ./"%s"',
        file_dir,
        file_path,
        file_name_no_ext,
        file_name_no_ext
      )
    end

  -- 4. Go Handling
  elseif file_ext == "go" then
    run_command = string.format('cd "%s" && go run "%s"', file_dir, file_path)

  -- Fallback for unsupported file types
  else
    print("Error: Active buffer layout cannot be automatically executed.")
    return
  end

  -- Fire up a horizontal split layout window and run the execution string natively
  vim.cmd("split | terminal " .. run_command)

  -- Force terminal window to follow your cursor focus automatically
  vim.cmd("startinsert")
end, { desc = "Run Active Code Buffer (C/C++/Py/Rust/Go)" })
