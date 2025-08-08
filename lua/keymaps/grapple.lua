local util = require("keymaps.util")

util.map("n", "<a-t>", "<cmd>Grapple toggle<cr>", {desc = "Grapple toggle"})
util.map("n", "<a-m>", "<cmd>Grapple toggle_tags<cr>", {desc = "Grapple menu"})
util.map("n", "<a-l>", "<cmd>Grapple cycle_tags next<cr>", {desc = "Grapple next"})
util.map("n", "<a-h>", "<cmd>Grapple cycle_tage prev<cr>", {desc = "Grapple prev"})
