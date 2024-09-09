return {
  {
    "folke/which-key.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>"] = {
          t = { name = "tabs" },
          f = { name = "file" },
          c = { name = "code" },
          g = { name = "goto" },
          h = { name = "help" },
          w = { name = "windows" },
          s = { name = "session" },
          r = { name = "search" },
          d = { name = "diagnostics/quickfix" },
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      -- wk.setup(opts)
      -- wk.add(opts.defaults)
    end,
  }
}
