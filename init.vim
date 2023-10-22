let mapleader =" "

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif


execute pathogen#infect()
syntax on
filetype plugin indent on


set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

filetype plugin on
set number relativenumber

set guifont=Source\ Code\ Pro:h11

augroup filetype_javascript
  autocmd!
  autocmd FileType javascript imap ;l console.log("");<Esc>hhi
  autocmd FileType javascript vmap ;l yoconsole.log();<Esc>hhp

  autocmd FileType javascript nmap <leader>f f"lgf<CR>
augroup END

" copy screenshot to documents/screenshots
:lua << EOF
  vim.api.nvim_create_user_command('Scr',
    function(opts)
      filename = opts.fargs[1]
      os.execute('cp ~/foo.png ~/Documents/screenshots/' .. filename)
    end,
    { nargs = 1 }
  )

EOF

command! -narg=1 B :G checkout -b ashwin/<q-args>

let g:gitgutter_map_keys = 0

let g:markdown_fenced_languages = ['rust','c', 'json', 'html', 'bash=sh']
let g:markdown_syntax_conceal = 0

let g:blamer_enabled = 0
let g:blamer_delay = 500
let g:blamer_relative_time = 1

let g:neovide_transparency=0.8
let g:transparency = 0.8
let g:neovide_refresh_rate= 120
let g:neovide_scroll_animation_length = 0.3
let g:neovide_background_color = '#05112e'.printf('%x', float2nr(255 * g:transparency))
let g:neovide_cursor_trail_size = 0
let g:neovide_cursor_vfx_mode = ""
let g:neovide_hide_mouse_when_typing = v:true
let g:neovide_cursor_antialiasing = v:false
let g:neovide_cursor_animate_in_insert_mode = v:true
let g:neovide_cursor_animation_length = 0.08
let g:neovide_scale_factor = 1.0
let g:neovide_floating_blur_amount_x = 2.0
let g:neovide_floating_blur_amount_y = 2.0

set background=dark

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

:nnoremap <leader>eb :vsplit ~/.zshrc<cr>
:nnoremap <leader>e3 :vsplit ~/.config/i3/config<cr>
:nnoremap <leader>en :vsplit ~/notes/index.md<cr>

set formatoptions-=cro 

nnoremap S :%s//g<Left><Left>
vnoremap S :%s//g<Left><Left>

nmap <leader>v "+p
nmap Y "+y

" nmap <C-p> :Files<CR>
" nmap <leader>p :Ag<CR>

nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap gh? <Plug>(GitGutterPreviewHunk)

nmap ghn <Plug>(GitGutterNextHunk)
nmap ghp <Plug>(GitGutterPrevHunk)
command P !~/.scripts/push.sh

" copy full path of current buffer
command! CP let @+ = expand('%:p')

map <leader><leader> <Esc>/<?><Enter>d3l
map <leader>/ i<?><Esc>

map <silent> e <Plug>CamelCaseMotion_iw

" latex stuf
let g:livepreview_previewer = 'zathura'
" map <leader>8 0y$i\begin{<Esc>A}<Enter><Esc>p0i\end{<Esc>A}<Esc>kA<Enter>

map <C-f> :NERDTreeFind<CR>
command F NERDTreeToggle


let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber


noremap <C-k> <C-w><C-k>
noremap <C-j> <C-w><C-j>
noremap <C-h> <C-w><C-h>
noremap <C-l> <C-w><C-l>

command H wincmd H

" Debugger
nnoremap <leader>dt :lua require("dapui").toggle()<CR>
nnoremap <leader>dk :DapTerminate<CR>
nnoremap <leader>db :DapToggleBreakpoint<CR>
nnoremap <leader>dc :DapContinue<CR>
nnoremap <leader>dr :lua require("dapui").open({reset = true})<CR>
nnoremap <leader>di :DapStepInto<CR>
nnoremap <leader>do :DapStepOver<CR>

noremap <C-S-k> <C-w>K
noremap <C-S-j> <C-w>J
noremap <C-S-h> <C-w>H
noremap <C-S-l> <C-w>L

nnoremap <leader>j J
nnoremap <leader>k K

nnoremap J <C-d>zz
nnoremap K <C-u>zz

noremap <leader>h gT
noremap <leader>l gt

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gv :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gt :call CocAction('jumpDefinition', 'tabe')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gp <Plug>(coc-diagnostic-prev)

" goto file in md formats
" nmap <leader>f _f(lgfs

" nmap <leader>a yiw<C-f>ma<C-r>"/<C-r>".md<CR>:q<CR>ysiw]f]a()<Esc>hpa/<Esc>pa.md<Esc>

nmap <leader>c :CocCommand<CR>

nnoremap <leader>q :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>af  <Plug>(coc-fix-current)


" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-i> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-i> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-i> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

map L $
map H _

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

let g:word_count=wordcount().words
function WordCount()
    if has_key(wordcount(),'visual_words')
        let g:word_count=wordcount().visual_words."/".wordcount().words " count selected words
    else
        let g:word_count=wordcount().cursor_words."/".wordcount().words " or shows words 'so far'
    endif
    return g:word_count
endfunction


set statusline=%{StatuslineGit()}
set statusline+=\ %f%m
set statusline+=\ %=wc:%{WordCount()}

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


:lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    disable = {"markdown"},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    }

}
EOF


:lua << EOF
require('rose-pine').setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = 'auto',
	--- @usage 'main'|'moon'|'dawn'
	dark_variant = 'main',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = 'base',
		background_nc = '_experimental_nc',
		panel = 'surface',
		panel_nc = 'base',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	-- https://github.com/rose-pine/neovim/wiki/Recipes
	highlight_groups = {
		ColorColumn = { bg = 'rose' },

		-- Blend colours against the "base" background
		CursorLine = { bg = 'foam', blend = 10 },
		StatusLine = { fg = 'love', bg = 'love', blend = 10 },
                StatusLineNC = { fg = "subtle", bg = "surface" },
                SignColumn = { bg = 'NONE' },
                TabLineFill = { bg = 'NONE' },

                TelescopeBorder = { fg = "highlight_high", bg = "none" },
		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "base" },
		TelescopeResultsNormal = { fg = "subtle", bg = "none" },
		TelescopeSelection = { fg = "text", bg = "base" },
		TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
	}
})
EOF

:lua << EOF
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>p', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
EOF

syntax enable
colorscheme rose-pine
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
" hi StatusLine ctermbg=0F202C guibg=#0F202C
hi StatusLineNC ctermbg=NONE guibg=NONE
hi ErrorMsg ctermbg=NONE guibg=NONE
hi TabLine ctermbg=NONE guibg=NONE
hi TabLineSel ctermbg=NONE guibg=NONE
hi TabLineFill ctermbg=NONE guibg=NONE

" DEBUGGER
:lua << EOF
function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

require("dapui").setup()
require("nvim-dap-virtual-text").setup()

local dap = require("dap")
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/home/vanilla/Downloads/extension/adapter/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    args = function()
      return mysplit(vim.fn.input('Args: '))
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

EOF


" let g:solarized_visibility="high"
" let g:solarized_diffmode="high"
set background=dark
