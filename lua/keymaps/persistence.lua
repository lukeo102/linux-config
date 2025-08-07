local util = require("keymaps.util")

util.map("n", "<leader>sl", function() require("persistence").load({last = true}) end, { desc = "Load last session", group = "Sessions" })
util.map("n", "<leader>ss", function() require("persistence").select() end, { desc = "Select session", group = "Sessions" })
