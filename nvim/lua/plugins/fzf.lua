return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({ "telescope" }) -- telescope-style layout

      local map = vim.keymap.set
      map("n", "<leader>ff", "<cmd>FzfLua files<CR>",       { desc = "Find files" })
      map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>",   { desc = "Live grep" })
      map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>",     { desc = "Buffers" })
      map("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>",    { desc = "Recent files" })
      map("n", "<leader>fh", "<cmd>FzfLua helptags<CR>",    { desc = "Help tags" })
      map("n", "<leader>/",  "<cmd>FzfLua grep_curbuf<CR>", { desc = "Search current buffer" })
    end,
  },
}
