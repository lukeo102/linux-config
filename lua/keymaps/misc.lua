local util = require("keymaps.util")

-- Keep visual mode after [un]indent
util.map("v", ">", ">gv", {})
util.map("v", "<", "<gv", {})

-- Move selection up/down
util.map("v", "J", ":m '>+1<cr>gv=gv", {})
util.map("v", "K", ":m '<-2<cr>gv=gv", {})

-- Quit/save
util.map("n", "<leader>qn", ":qa!<cr>", { desc = "Quit all" })
util.map("v", "<leader>qn", ":qa!<cr>", { desc = "Quit all" })
util.map("n", "<leader>qw", ":wa!<cr>", { desc = "Save all" })
util.map("v", "<leader>qw", ":wa!<cr>", { desc = "Save all" })
util.map("n", "<leader>qx", "<leader>qw:qa<cr>", { desc = "Save and quit all" })
util.map("v", "<leader>qx", "<leader>qw:qa<cr>", { desc = "Save and quit all" })


