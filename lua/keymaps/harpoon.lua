local util = require("keymaps.util")

util.map("n", "<a-m>", function () return require("harpoon").ui:toggle_quick_menu() end, {desc = "Harpoon menu"})
util.map("n", "<a-a>", function () return require("harpoon"):list():add() end, {desc = "Harpoon add"})
util.map("n", "<a-l>", function () return require("harpoon"):list():next() end, {desc = "Harpoon next"})
util.map("n", "<a-h>", function () return require("harpoon"):list():prev() end, {desc = "Harpoon previous"})
