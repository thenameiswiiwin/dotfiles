local lspconfig = require("lspconfig")
local configs = require "lspconfig.configs"

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)

local on_attach = function(client, bufnr)

  lsp_status.on_attach(client)
  mapBuf(bufnr, "n", "<Leader>gdc", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
  mapBuf(bufnr, "n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
  mapBuf(bufnr, "n", "<Leader>gh", "<Cmd>lua vim.lsp.buf.hover()<CR>")
  mapBuf(bufnr, "n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  mapBuf(bufnr, "n", "<Leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  mapBuf(bufnr, "n", "<Leader>gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  mapBuf(bufnr, "n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  mapBuf(bufnr, "n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  -- mapBuf(bufnr, "n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  mapBuf(bufnr, "n", "<Leader>ca", "<cmd> lua require('mh.telescope').code_actions()<cr>")
  mapBuf(bufnr, "v", "<Leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
  mapBuf(bufnr, "n", "<Leader>sd", "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<CR>")
  -- autocmd("CrsorHold", "<buffer>", "lua vim.diagnostic.show_position_diagnostics({focusable=false})")u

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  vim.fn.sign_define("DiagnosticSignError", {text = "•", texthl = "DiagnosticSignError"})
  vim.fn.sign_define("DiagnosticSignWarn", {text = "•", texthl = "DiagnosticSignWarn"})
  vim.fn.sign_define("DiagnosticSignInfo", {text = "•", texthl = "DiagnosticSignInfo"})
  vim.fn.sign_define("DiagnosticSignHint", {text = "•", texthl = "DiagnosticSignHint"})

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
  end
end

local servers = { "tsserver", "tailwindcss", "html", "cssls", "bashls", "vimls" }
for _, lsp in ipairs(servers) do 
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end
lspconfig.sourcekit.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
configs.emmet_ls = {
  default_config = {
    cmd = {"emmet-ls", "--stdio"},
    filetypes = {"html", "css", "scss"},
    root_dir = function()
      return vim.loop.cwd()
    end,
    settings = {}
  }
}
lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.jsonls.setup {
  cmd = {"vscode-json-language-server", "--stdio"},
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"json", "jsonc"},
  settings = {
    json = {
      -- Schemas https://www.schemastore.org
      schemas = {
        {
          fileMatch = {"package.json"},
          url = "https://json.schemastore.org/package.json"
        },
        {fileMatch={"manifest.json", "manifest.webmanifest"},
          url="https://json.schemastore.org/web-manifest-combined.json"
        },
        {
          fileMatch = {"tsconfig*.json"},
          url = "https://json.schemastore.org/tsconfig.json"
        },
        {
          fileMatch = {
            ".prettierrc",
            ".prettierrc.json",
            "prettier.config.json"
          },
          url = "https://json.schemastore.org/prettierrc.json"
        },
        {
          fileMatch = {".eslintrc", ".eslintrc.json"},
          url = "https://json.schemastore.org/eslintrc.json"
        },
        {
          fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"},
          url = "https://json.schemastore.org/babelrc.json"
        },
        {
          fileMatch = {"lerna.json"},
          url = "https://json.schemastore.org/lerna.json"
        },
        {
          fileMatch = {"now.json", "vercel.json"},
          url = "https://json.schemastore.org/now.json"
        },
        {
          fileMatch = {
            ".stylelintrc",
            ".stylelintrc.json",
            "stylelint.config.json"
          },
          url = "http://json.schemastore.org/stylelintrc.json"
        }
      }
    }
  }
}
