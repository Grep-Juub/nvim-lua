return {
  {
    'VonHeikemen/lsp-zero.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Mason',
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
      require('mason').setup({})
      require('mason-lspconfig').setup({
        -- Replace the language servers listed here
        -- with the ones you want to install
        ensure_installed= {
          "ansiblels",
          "bashls",
          "eslint",
          "lua_ls",
          "terraformls"
        },

        handlers = {
          lsp.default_setup,
        },
      })

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
        local opts = {buffer = bufnr}

        vim.keymap.set({'n', 'x'}, 'gq', function()
          vim.lsp.buf.format({async = false, timeout_ms = 10000})
        end, opts)
      end)


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
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
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
