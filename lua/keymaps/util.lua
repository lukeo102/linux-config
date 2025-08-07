local wk = require("which-key")

function map(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs)
    if opts["group"] == nil then
        wk.add({ { lhs, desc = opts["desc"] } })
    else
        wk.add({ { lhs, desc = opts["desc"], group = opts["group"],
            expand = function ()
                return require("which-key.extras").expand.buf()
            end
        } })
    end
end



return {
	map = map,
}
