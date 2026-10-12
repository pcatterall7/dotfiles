-- marksman: wikilinks, backlinks, rename, broken-link diagnostics
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    -- treat an Obsidian vault as the workspace root
    local root = vim.fs.root(args.buf, { ".obsidian", ".marksman.toml", ".git" })
    vim.lsp.start({
      name = "marksman",
      cmd = { "marksman", "server" },
      root_dir = root or vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
    })
  end,
})

-- heading outline: custom picker instead of FzfLua lsp_document_symbols, whose
-- tab-separated format makes the indentation depend on line-number width.
-- Indents by heading nesting depth, in document order.
local function heading_outline()
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }

  vim.lsp.buf_request(buf, "textDocument/documentSymbol", params, function(err, result)
    if err or not result then
      return
    end

    local entries = {}
    local function walk(symbols, depth)
      for _, sym in ipairs(symbols) do
        local range = sym.selectionRange or sym.range or sym.location.range
        table.insert(entries, string.format("%4d  %s%s", range.start.line + 1, ("  "):rep(depth), sym.name))
        walk(sym.children or {}, depth + 1)
      end
    end
    walk(result, 0)

    require("fzf-lua").fzf_exec(entries, {
      prompt = "Headings> ",
      winopts = { title = " Headings " },
      fzf_opts = { ["--layout"] = "reverse" },
      actions = {
        ["default"] = function(selected)
          local lnum = tonumber(selected[1]:match("^%s*(%d+)"))
          if lnum then
            vim.api.nvim_win_set_cursor(win, { lnum, 0 })
          end
        end,
      },
    })
  end)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", "<cmd>FzfLua lsp_references<CR>", "References / backlinks")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ss", heading_outline, "Document symbols")
  end,
})
