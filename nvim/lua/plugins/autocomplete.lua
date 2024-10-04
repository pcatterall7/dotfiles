return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.enabled = function()
        -- Disable completion in text files
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if vim.bo.filetype == "text" or vim.bo.filetype == "markdown" or buftype == "prompt" then
          return false
        end
        return true
      end
    end,
  },
}
