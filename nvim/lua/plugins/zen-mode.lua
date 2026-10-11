return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>tz", "<cmd>ZenMode<CR>", desc = "Toggle centered prose mode" },
    },
    opts = {
      window = {
        width = 80, -- max text width in columns
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          list = false,
          cursorline = false,
        },
      },
      plugins = {
        options = { laststatus = 0 },
        tmux = { enabled = false },
      },
    },
  },
}
