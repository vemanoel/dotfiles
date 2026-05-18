vim.opt.fillchars:append({ eob = " " })
vim.g.netrw_banner = 0

vim.lsp.enable("gopls")
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod" },
  settings = {
    gopls = {
      diagnosticsTrigger = "Edit",
      semanticTokens = true,
      staticcheck = true,
      diagnosticsDelay = "1s",
      hoverKind = "SingleLine",
      analyses = {
        shadow = true,
        unusedparams = true,
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
      })
    end
  end,
})
