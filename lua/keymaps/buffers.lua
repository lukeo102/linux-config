local util = require("keymaps.util")

-- Buffers
util.map("n", "<S-k>", "<cmd>bnext<cr>", { desc = "Next buffer" })
util.map("n", "<S-j>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
util.map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

util.map("n", "<S-h>", "<c-w>h", { desc = "Window left" })
util.map("n", "<S-l>", "<c-w>l", { desc = "Window right" })
