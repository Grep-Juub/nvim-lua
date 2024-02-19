cmd = vim.cmd

cmd(":command! -nargs=0 W w")

-- Fix wrong filetype detection of newly created files when using terraform
cmd('autocmd BufNewFile,BufRead *.tf,*.hcl setfiletype terraform')

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl", "tf" },
})

vim.api.nvim_set_keymap('n', '<Del>', '"_x', {noremap = true, silent = true})
