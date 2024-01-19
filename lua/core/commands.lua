cmd = vim.cmd

cmd(":command! -nargs=0 W w")

-- Fix wrong filetype detection of newly created files when using terraform
cmd('autocmd BufNewFile,BufRead *.tf,*.hcl setfiletype terraform')


