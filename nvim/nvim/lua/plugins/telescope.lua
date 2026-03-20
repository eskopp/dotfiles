return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          -- Include hidden files in searches.
          -- This is especially useful for dotfiles such as .zshrc or files inside .config.
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob",
            "!.git",
          },
        },
        pickers = {
          find_files = {
            -- Show hidden files, but do not enter the .git directory.
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!.git",
            },
          },
        },
      })

      -- Return the Git repository root if available.
      -- If the current working directory is not inside a Git repository,
      -- fall back to Neovim's current working directory.
      local function project_root()
        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if vim.v.shell_error == 0 and git_root and git_root ~= "" then
          return git_root
        end
        return vim.loop.cwd()
      end

      -- Open Telescope file search in a specific directory.
      local function find_files_in(path)
        builtin.find_files({
          cwd = path,
          hidden = true,
        })
      end

      -- Open Telescope live grep in a specific directory.
      local function live_grep_in(path)
        builtin.live_grep({
          cwd = path,
        })
      end

      -- Generic Telescope shortcuts.
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })

      -- Search from the Git repository root.
      vim.keymap.set("n", "<leader>fr", function()
        find_files_in(project_root())
      end, { desc = "Find files in repo root" })

      vim.keymap.set("n", "<leader>gr", function()
        live_grep_in(project_root())
      end, { desc = "Live grep in repo root" })

      -- Search from the current working directory.
      vim.keymap.set("n", "<leader>f.", function()
        find_files_in(vim.loop.cwd())
      end, { desc = "Find files in current directory" })

      vim.keymap.set("n", "<leader>g.", function()
        live_grep_in(vim.loop.cwd())
      end, { desc = "Live grep in current directory" })

      -- Search from the user's home directory.
      vim.keymap.set("n", "<leader>f~", function()
        find_files_in(vim.fn.expand("~"))
      end, { desc = "Find files in home directory" })

      vim.keymap.set("n", "<leader>g~", function()
        live_grep_in(vim.fn.expand("~"))
      end, { desc = "Live grep in home directory" })

      -- Search from the filesystem root.
      -- This can be slower on large systems.
      vim.keymap.set("n", "<leader>f/", function()
        find_files_in("/")
      end, { desc = "Find files from filesystem root" })

      vim.keymap.set("n", "<leader>g/", function()
        live_grep_in("/")
      end, { desc = "Live grep from filesystem root" })
    end,
  },
}
