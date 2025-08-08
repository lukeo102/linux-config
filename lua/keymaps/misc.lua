local util = require("keymaps.util")

-- Code
util.map("n", "<leader>cd", "<C-w>d", {desc = "Code diagnostics"})
util.map("n", "<leader>cs", function () return vim.lsp.buf.definition() end, {desc = "Goto definiton"})
util.map("n", "<leader>ci", function () return vim.lsp.buf.hover() end, {desc = "Information under cursor"})
util.map("n", "<leader>ca", function () return vim.lsp.buf.code_action end, {desc = "Code actions"})
util.map("n", "<leader>cr", function () return vim.lsp.buf.rename end, {desc = "Rename symbol"})
util.map("n", "<C-k>", function () return require("snacks").words.jump(vim.v.count1) end, {desc = "Next reference"})
util.map("n", "<C-j>", function () return require("snacks").words.jump(-vim.v.count1) end, {desc = "Previous reference"})

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


