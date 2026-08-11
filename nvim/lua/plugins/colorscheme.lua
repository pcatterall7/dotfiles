return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 999,
    config = function()
      require("tokyonight").setup({ style = "night" })
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    priority = 999,
  },
  {
    'mcncl/alabaster.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('alabaster')
    end,
  }
}
