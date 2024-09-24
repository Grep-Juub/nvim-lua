return {
  {
    'VonHeikemen/lsp-zero.nvim',
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    cmd = 'Mason',
    lazy = false,
    branch = 'v3.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end
      },
      { 'williamboman/mason-lspconfig.nvim', },

      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      local lsp = require('lsp-zero')

      lsp.set_sign_icons({
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»'
      })
      require('mason').setup(
        {opts = { ensure_installed = { "goimports", "gofumpt" } }
      })
      require('mason-lspconfig').setup({
        -- Replace the language servers listed here
        -- with the ones you want to install
        ensure_installed = {
          "jsonls",
          "pyright",
          "ansiblels",
          "bashls",
          "eslint",
          "lua_ls",
          "terraformls",
          "tflint",
          "helm_ls",
          "jsonnet_ls",
          "ast_grep",
          "gopls",
        },

        handlers = {
          lsp.default_setup,
          helm_ls = function ()
            local util = require('lspconfig.util')
            require("lspconfig").helm_ls.setup({
              cmd = {"helm_ls", "serve"},
              filetypes = {'helm'},
              root_dir = function(fname)
                return util.root_pattern('Chart.yaml')(fname)
              end,
              valuesFiles = {
                mainValuesFile = "values.yaml",
                lintOverlayValuesFile = "values.lint.yaml",
                additionalValuesFilesGlobPattern = "values*.yaml"
              },
            })
          end,
          ast_grep = function ()
            local util = require('lspconfig.util')
            require("lspconfig").ast_grep.setup({
              cmd = { "ast-grep", "lsp" },
              filetypes = { "c", "cpp", "rust", "go", "java", "python", "javascript", "typescript", "html", "css", "kotlin", "dart", "lua" },
              root_dir = function (fname)
                return util.root_pattern('~/.config/ast-grep/sgconfig.yml')(fname)
              end,
            })
          end,
          gopls = function ()
            require("lspconfig").gopls.setup({
              settings = {
                gopls = {
                  gofumpt = true
                }
              }
            })
          end,
          terraformls = function()
            require("lspconfig").terraformls.setup({
              filetypes = { 'terraform' },
              settings = {
                validateOnSave = true,
              },
              init_options = {
                experimentalFeatures = {
                  prefillRequiredFields = true,
                },
              },
            })
          end
        },
      })

      lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        local opts = { buffer = bufnr }

        vim.keymap.set({ 'n', 'x' }, 'gq', function()
          vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end, opts)
      end)

      lsp.set_server_config({
        on_init = function(client)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      lsp.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 1000,
        },
        servers = {
          ['terraformls'] = { 'hcl', 'terraform', 'tf'},
          ['jsonls'] = { 'json' },
          ['gopls'] = { 'go' },
        }
      })


      local cmp = require('cmp')
      -- local cmp_action = require('lsp-zero').cmp_action()

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'luasnip' },
          { name = "buffer" },
          { name = "path" },
        },
        mapping = {
          ['<TAB>'] = cmp.mapping.confirm({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
            { name = "cmdline" },
          }),
      })
    end
  },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'rafamadriz/friendly-snippets' },
}
--
-- return {}
