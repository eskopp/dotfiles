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
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      local function open_neotree_with_preview()
        vim.cmd("Neotree action=focus source=filesystem position=left toggle=true reveal=true")
        vim.schedule(function()
          if vim.bo.filetype == "neo-tree" then
            vim.api.nvim_feedkeys("P", "m", false)
          end
        end)
      end

      vim.keymap.set("n", "<leader>e", open_neotree_with_preview, {
        desc = "Neo-tree explorer with auto preview",
      })
    end,
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        position = "left",
        width = 36,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = "open_default",
        window = {
          mappings = {
            ["<cr>"] = "none",
            ["o"] = "none",
            ["<2-LeftMouse>"] = "none",
            ["s"] = "none",
            ["S"] = "none",
            ["t"] = "none",
            ["w"] = "none",

            ["P"] = {
              "toggle_preview",
              config = {
                use_float = false,
              },
            },

            ["l"] = "toggle_node",
            ["<Right>"] = "toggle_node",
            ["h"] = "close_node",
            ["<Left>"] = "close_node",

            ["<bs>"] = "navigate_up",
            ["<C-f>"] = "scroll_preview",
            ["<C-b>"] = "scroll_preview",
            ["<Esc>"] = "revert_preview",
            ["q"] = "close_window",
            ["H"] = "toggle_hidden",
            ["R"] = "refresh",
            ["/"] = "none",
          },
        },
      },
    },
  },
}
