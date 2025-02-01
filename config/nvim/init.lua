--   _   _                 _       _ _     _
-- | | | |_   _ _   _ ___(_)_ __ (_) |_  | |_   _  __ _
-- | |_| | | | | | | / __| | '_ \| | __| | | | | |/ _` |
-- |  _  | |_| | |_| \__ \ | | | | | |_ _| | |_| | (_| |
-- |_| |_|\__,_|\__, |___/_|_| |_|_|\__(_)_|\__,_|\__,_|
--              |___/
-- Author: Huy Nguyen
-- repo  : https://github.com/thenameiswiiwin/dotfiles/

vim.g.mapleader = ","
vim.o.tgc = true
vim.o.guifont = "VictorMono Nerd Font Mono:h20"
-- vim.opt.linespace = 1.2
require("hn.plugins")
require("hn.options")
require("hn.mappings")
require("hn.commands")
require("hn.completion")
require("hn.colors")

require("hn.autocmds")
require("hn.folds")
require("hn.filetree")
require("hn.statusline")
require("hn.tabline")
require("hn.treesitter")
require("hn.formatting")
require("hn.lsp")
