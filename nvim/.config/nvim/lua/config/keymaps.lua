local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { desc = desc })
end

-- Keymaps
-- map('<C-i>', 'i<cr><Esc>', 'Insert Carriage Return')
map('<Esc>', '<cmd>nohlsearch<CR>', 'Remove Search Highlighting')

-- Windows
map('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

-- LSP
local builtin = require('telescope.builtin')
map('<leader>q', builtin.quickfix, 'Open diagnostic [Q]uickfix list')
map('<C-K>', vim.lsp.buf.hover, 'Documentation')
-- map('<leader>f', function()
--     require('conform').format({ async = true, lsp_format = 'fallback' })
-- end, '[F]ormat buffer')
map('grf', vim.lsp.buf.format, '[F]ormat')
map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
map('gra', vim.lsp.buf.code_action, '[G]oto code [a]ction', { 'n', 'x' })
map('grr', builtin.lsp_references, '[G]oto [r]eferences')
map('gri', builtin.lsp_implementations, '[G]oto [i]mplementation')
map('grd', builtin.lsp_definitions, '[G]oto [d]efinition')
map('grd', vim.lsp.buf.declaration, '[G]oto [d]eclaration')
map('gO', builtin.lsp_document_symbols, 'Open Document Symbols')
map('gW', builtin.lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
map('grt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')

-- Search
map('<leader>sb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', '[S]earch File [B]rowser')
map('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
map('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
map('<leader>sf', builtin.find_files, '[S]earch [F]iles')
map('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
map('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
map('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
map('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
map('<leader>sr', builtin.resume, '[S]earch [R]esume')
map('<leader>s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')
map('<leader><leader>', builtin.buffers, '[ ] Find existing buffers')
map('<leader>s,', ':Telescope frecency<CR>', '[,] Search frecent files')

map('<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, '[/] Fuzzily search in current buffer')

map('<leader>s/', function()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    })
end, '[S]earch [/] in Open Files')

-- Shortcut for searching your Neovim configuration files
map('<leader>sn', function()
    builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, '[S]earch [N]eovim files')

-- Debugging
local dap = require('dap')
map('<leader>dt', dap.toggle_breakpoint, '[D]ebug Breakpoint [T]oggle')
map('<leader>dc', dap.continue, '[D]ebug Breakpoint [C]ontinue')

-- Gitsigns
local gitsigns = require('gitsigns')

map(']c', function()
    if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
    else
        gitsigns.nav_hunk('next')
    end
end, 'Jump to next git [c]hange')

map('[c', function()
    if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
    else
        gitsigns.nav_hunk('prev')
    end
end, 'Jump to previous git [c]hange')

map('<leader>hs', gitsigns.stage_hunk, 'git [s]tage hunk')
map('<leader>hr', gitsigns.reset_hunk, 'git [r]eset hunk')
map('<leader>hS', gitsigns.stage_buffer, 'git [S]tage buffer')
map('<leader>hu', gitsigns.stage_hunk, 'git [u]ndo stage hunk')
map('<leader>hR', gitsigns.reset_buffer, 'git [R]eset buffer')
map('<leader>hp', gitsigns.preview_hunk, 'git [p]review hunk')
map('<leader>hb', gitsigns.blame_line, 'git [b]lame line')
map('<leader>hd', gitsigns.diffthis, 'git [d]iff against index')
map('<leader>hD', function()
    gitsigns.diffthis('@')
end, 'git [D]iff against last commit')
map('<leader>tb', gitsigns.toggle_current_line_blame, '[T]oggle git show [b]lame line')
map('<leader>tD', gitsigns.preview_hunk_inline, '[T]oggle git show [D]eleted')

map('<leader>hs', function()
    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, 'git [s]tage hunk', 'v')
map('<leader>hr', function()
    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, 'git [r]eset hunk')
