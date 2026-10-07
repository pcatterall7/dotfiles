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
    "mcncl/alabaster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- dark: tokyonight-night, light: alabaster
      local function apply()
        local name = vim.o.background == "dark" and "tokyonight-night" or "alabaster"
        if vim.g.colors_name ~= name then
          vim.cmd.colorscheme(name)
        end
      end
      vim.api.nvim_create_autocmd("OptionSet", { pattern = "background", callback = apply })
      apply()
    end,
  },
  -- follow the macOS light/dark appearance (needs the dark-notify binary,
  -- installed by mac-setup.sh); sets 'background', which triggers the autocmd above
  {
    "cormacrelf/dark-notify",
    config = function()
      require("dark_notify").run()
    end,
  },
}
