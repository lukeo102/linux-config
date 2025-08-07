local util = require("keymaps.util")

util.map("v", "if", "@function.inner", { desc = "Inner function" })
util.map("v", "af", "@function.outer", { desc = "Around function" })
