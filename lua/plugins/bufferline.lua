return {
    'akinsho/bufferline.nvim', 
    version = "v4.9.1", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            offsets = {
                {
                filetype = "snacks_layout_box",
                },
            },
            themable = true,
            show_close_icon = false,
            show_buffer_close_icon = false,
            separator_style = "slant"
        }
    },
    config = function (_, opts)
        vim.opt.termguicolors = true
        require("bufferline").setup(opts)
    end
}
