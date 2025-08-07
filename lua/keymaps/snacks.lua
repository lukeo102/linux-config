local util = require("keymaps.util")

util.map("n", "<leader>e", function() require("snacks").explorer() end, { desc = "Toggle file picker" })
