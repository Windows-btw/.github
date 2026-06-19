-- Options are automatically loaded before lazy.nvim startup
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- If neovide is running, set the Nerd Font and font size
if vim.g.neovide then
  -- Example: setting JetBrainsMono Nerd Font to size 12
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
end
--
-- Force LazyVim to always respect your Current Working Directory instead of looking for project roots
vim.g.lazyvim_picker = "snacks"
vim.g.root_spec = { "cwd" }
if vim.g.neovide then
  -- This controls the alpha layer of the window frame
  vim.g.neovide_opacity = 0.7

  -- This forces the actual text grid pixels to match the transparency scale
  vim.g.neovide_normal_opacity = 0.7

  -- Disable blur entirely for testing (makes background starkly clear)
  vim.g.neovide_window_blurred = false
end
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
