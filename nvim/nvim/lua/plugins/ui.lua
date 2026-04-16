return {
  {
    "vim-airline/vim-airline",
    dependencies = {
      "vim-airline/vim-airline-themes",
    },
    init = function()
      vim.g.airline_theme = "nord"
      vim.g.airline_powerline_fonts = 1

      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#tabline#formatter"] = "unique_tail"

      vim.g.airline_left_sep = vim.fn.nr2char(0xE0B0)
      vim.g.airline_left_alt_sep = vim.fn.nr2char(0xE0B1)
      vim.g.airline_right_sep = vim.fn.nr2char(0xE0B2)
      vim.g.airline_right_alt_sep = vim.fn.nr2char(0xE0B3)

      vim.g.airline_section_warning = ""
      vim.g.airline_section_error = ""

      vim.g.airline_section_x = "%{&filetype}"
      vim.g.airline_section_y = "%{&fileencoding==''?&encoding:&fileencoding}[%{&fileformat}]"
      vim.g.airline_section_z = "%3p%% %3l:%-2v"
    end,
  },
}
