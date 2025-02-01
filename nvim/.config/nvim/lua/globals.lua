-- Prevent Netrw from showing up at beginning
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.clipboard = {
  name = "macOS-clipboard",
  copy = {["+"] = "pbcopy", ["*"] = "pbcopy"},
  paste = {["+"] = "pbpaste", ["*"] = "pbpaste"},
  cache_enabled = false
}

