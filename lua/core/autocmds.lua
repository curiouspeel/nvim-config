-----------------------------------------------------------
-- Autocommand functions
-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
-----------------------------------------------------------

vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end


" from https://github.com/kyazdani42/nvim-tree.lua#tips--reminders
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" format on save except the following
let ftToIgnore = ['c', 'markdown', 'javascript']
    autocmd BufWritePre * if index(ftToIgnore, &ft) < 0 | lua vim.lsp.buf.formatting_sync()

]])

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Highlight on yank
augroup('YankHighlight', { clear = true })

autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '350' })
  end
})

-- Remove whitespace on save
-- autocmd('BufWritePre', {
--   pattern = '*',
--   command = ":%s/\\s\\+$//e"
-- })

-- -- Don't auto commenting new lines
-- autocmd('BufEnter', {
--   pattern = '*',
--   command = 'set fo-=c fo-=r fo-=o'
-- })

-- Settings for fyletypes:
-- Disable line lenght marker
-- augroup('setLineLenght', { clear = true })
-- autocmd('Filetype', {
--   group = 'setLineLenght',
--   pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
--   command = 'setlocal cc=0'
-- })

-- Set indentation to 2 spaces
-- augroup('setIndent', { clear = true })
-- autocmd('Filetype', {
--   group = 'setIndent',
--   pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
--     'yaml', 'lua'
--   },
--   command = 'setlocal shiftwidth=2 tabstop=2'
-- })

