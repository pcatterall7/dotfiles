return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({ style = "night" })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    priority = 999,
  },
}
