-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

local api = vim.api
local g = vim.g

local p = require('dark.palette')

local function hl(name, fg, bg, style, sp)
  local hl_map = { fg = fg, bg = bg, sp = sp }
  if type(style) == 'string' then
    hl_map[style] = 1
  elseif type(style) == 'table' then
    for _, v in ipairs(style) do
      hl_map[v] = 1
    end
  end
  api.nvim_set_hl(0, name, hl_map)
end

local function li(target, source)
  api.nvim_set_hl(0, target, { link = source })
end

function M.init()
  --[[ The CursorLine background will be overloaded by any group
  that defines a background value.
  Do not link to Normal group. Instead, link to this group.
  see https://github.com/neovim/neovim/issues/9019 ]]
  hl('Fg', p.fg)

  -- helper groups
  hl('Error', p.error)
  hl('Warning', p.warning)
  hl('Information', p.unused)
  hl('Hint', p.hint)
  hl('ErrorUnderline', nil, nil, 'underline', p.error_effect)
  hl('WarnUnderline', nil, nil, 'underline', p.warn_effect)
  hl('InfoUnderline', nil, nil, 'underdashed', p.info_effect)
  hl('HintUnderline', nil, nil, 'underdashed', p.hint_effect)
  hl('ErrorSign', p.error_stripe)
  hl('WarningSign', p.warning_stripe)
  hl('InformationSign', p.information_stripe)
  hl('HintSign', p.hint_stripe)
  hl('IdentifierUnderCaret', nil, p.word_under_caret)
  hl('IdentifierUnderCaretWrite', nil, p.word_under_caret_w)
  hl('GitAddSign', p.add_stripe)
  hl('GitChangeSign', p.change_stripe)
  hl('GitDeleteSign', p.delete_stripe)
  hl('GitChangeDeleteSign', p.whitespace_stripe)

  -- builtin groups `:h highlight-groups`
  hl('ColorColumn', nil, p.wrap_guide)
  hl('Conceal', p.comment)
  hl('Cursor', p.cursor)
  li('lCursor', 'Cursor')
  li('CursorIM', 'Cursor')
  li('CursorColumn', 'CursorLine')
  hl('CursorLine', nil, p.cursor_line)
  li('Directory', 'Fg')
  hl('DiffAdd', nil, p.diff_add)
  hl('DiffChange', nil, p.diff_change)
  hl('DiffDelete', nil, p.diff_delete)
  hl('DiffText', nil, p.diff_text)
  li('EndOfBuffer', 'NonText')
  -- TermCursor
  -- TermCursorNC
  li('ErrorMsg', 'Error')
  hl('VertSplit', p.comment)
  hl('Folded', p.folded_fg, p.folded_bg)
  hl('FoldColumn', p.comment)
  hl('SignColumn', nil, nil)
  hl('IncSearch', nil, p.inc_search)
  li('CurSearch', 'IncSearch')
  li('Substitute', 'Search')
  hl('LineNr', p.fg)
  hl('CursorLineNr', p.constant, nil, 'bold')
  hl('MatchParen', nil, p.match_brace)
  hl('ModeMsg', p.std_output)
  li('MsgArea', 'Fg')
  li('MsgSeparator', 'StatusLine')
  li('MoreMsg', 'Fg')
  hl('NonText', p.comment)
  hl('Normal', p.fg, p.bg)
  li('NormalFloat', 'Pmenu')
  li('NormalNC', 'Fg')
  hl('Pmenu', p.fg, p.menu)
  hl('PmenuSel', nil, p.menu_sel)
  hl('PmenuSbar', p.menu, p.menu)
  hl('PmenuThumb', p.menu_thumb, p.menu_thumb)
  li('Question', 'Fg')
  hl('QuickFixLine', nil, p.selection)
  hl('Search', nil, p.search)
  li('SpecialKey', 'NonText')
  hl('SpellBad', p.typo, nil, 'underline')
  li('SpellCap', 'SpellBad')
  li('SpellLocal', 'SpellBad')
  li('SpellRare', 'SpellBad')
  hl('StatusLine', p.ui_frame_fg, p.ui_frame_bg)
  hl('StatusLineNC', p.ui_frame_fg, p.ui_frame_bg)
  hl('TabLine', p.fg, p.ui_frame_bg)
  hl('TabLineFill', p.ui_frame_bg, p.ui_frame_bg)
  hl('TabLineSel', p.fg, p.ui_frame_bg)
  li('Title', 'Special')
  hl('Visual', nil, p.selection)
  li('VisualNOS', 'Visual')
  li('WarningMsg', 'Warning')
  li('Whitespace', 'NonText')
  li('WildMenu', 'PmenuSel')
  li('WinBar', 'StatusLine')
  li('WinBarNC', 'StatusLineNC')
  hl('WinSeparator', nil, p.ui_frame_bg)

  -- common groups `:h group-name`
  hl('Comment', p.comment, nil, 'italic')
  hl('Constant', p.constant, nil, { 'italic', 'bold' })
  hl('String', p.string)
  li('Character', 'String')
  hl('Number', p.number)
  li('Boolean', 'Keyword')
  li('Float', 'Number')
  li('Identifier', 'Fg')
  hl('Function', p['function'], nil, 'bold')
  li('Statement', 'Keyword')
  li('Conditional', 'Keyword')
  li('Repeat', 'Keyword')
  li('Label', 'Keyword')
  li('Operator', 'Keyword')
  hl('Keyword', p.keyword, nil, 'bold')
  li('Exception', 'Keyword')
  li('PreProc', 'Keyword')
  li('Include', 'PreProc')
  li('Define', 'PreProc')
  li('Macro', 'PreProc')
  li('PreCondit', 'PreProc')
  li('Type', 'Keyword')
  li('StorageClass', 'Keyword')
  li('Structure', 'Keyword')
  li('Typedef', 'Keyword')
  li('Special', 'PreProc')
  li('SpecialChar', 'PreProc')
  li('Tag', 'Keyword')
  li('Delimiter', 'Keyword')
  hl('SpecialComment', p.comment_tag, nil, 'italic')
  hl('Debug', p.debug, nil, 'italic')
  -- Ignore
  -- Error defined above
  hl('Underlined', p.fg, nil, 'underline')
  hl('Todo', p.todo, nil, { 'bold', 'italic' })

  -- some other groups
  li('healthSuccess', 'IncSearh')
  hl('NvimInternalError', p.error, p.error)
  hl('RedrawDebugClear', p.fg, p.duplicate_from_server)
  hl('RedrawDebugComposed', p.fg, p.search)
  li('RedrawDebugRecompose', 'Error')
  hl('FloatBorder', p.fg, p.menu)

  -- builtin terminal colors
  g.terminal_color_0 = p.ansi_black
  g.terminal_color_1 = p.ansi_red
  g.terminal_color_2 = p.ansi_green
  g.terminal_color_3 = p.ansi_yellow
  g.terminal_color_4 = p.ansi_blue
  g.terminal_color_5 = p.ansi_magenta
  g.terminal_color_6 = p.ansi_cyan
  g.terminal_color_7 = p.ansi_white
  g.terminal_color_8 = p.ansi_b_black
  g.terminal_color_9 = p.ansi_b_red
  g.terminal_color_10 = p.ansi_b_green
  g.terminal_color_11 = p.ansi_b_yellow
  g.terminal_color_12 = p.ansi_b_blue
  g.terminal_color_13 = p.ansi_b_magenta
  g.terminal_color_14 = p.ansi_b_cyan
  g.terminal_color_15 = p.ansi_b_white

  -- Treesitter
  li('@text.literal', 'Fg')
  li('@text.reference', 'Comment')
  hl('@text.title', p.constant, nil, { 'italic' })
  hl('@text.uri', p.todo, nil, 'italic')
  hl('@text.underline', p.fg, nil, 'underline')
  li('@text.todo', 'Todo')
  li('@text.warning', 'Todo') -- used for highlight "TODO" in comment
  li('@comment', 'Comment')
  li('@punctuation', 'Fg')
  li('@punctuation.bracket', 'Fg')
  li('@punctuation.special', 'Keyword')
  li('@constant', 'Constant')
  li('@constant.builtin', 'Constant')
  hl('@constant.macro', p.meta_data)
  li('@define', 'Keyword')
  li('@macro', '@constant.macro')
  li('@string', 'String')
  hl('@string.escape', p.escape_seq)
  li('@string.special', '@string.escape')
  li('@string.regex', 'Number')
  li('@character', 'Character')
  li('@character.special', 'Character')
  li('@number', 'Number')
  li('@boolean', 'Keyword')
  li('@float', 'Number')
  li('@function', 'Function')
  hl('@function.call', p['function'])
  li('@function.builtin', 'Fg')
  li('@function.macro', '@constant.macro')
  li('@parameter', 'Fg')
  hl('@method', p.instance_method)
  li('@method.call', '@method')
  hl('@field', p.constant)
  li('@property', '@field')
  li('@constructor', 'Function')
  li('@conditional', 'Keyword')
  li('@repeat', 'Keyword')
  hl('@label', p.constant)
  li('@operator', 'Fg')
  li('@keyword', 'Keyword')
  li('@exception', 'Keyword')
  li('@variable', 'Fg')
  li('@variable.builtin', 'Constant')
  li('@type', 'Fg')
  li('@type.definition', 'Keyword')
  li('@type.builtin', 'Keyword')
  li('@type.qualifier', 'Keyword')
  li('@storageclass', 'Keyword')
  hl('@structure', p.namespace) -- TODO need check
  hl('@namespace', p.namespace)
  li('@include', 'Keyword')
  li('@preproc', 'Keyword')
  li('@debug', 'Debug')
  hl('@tag', p.tag)
  hl('@tag.attribute', p.fg)
  li('@tag.delimiter', 'Fg')
  hl('@strong', p.fg, nil, 'bold')
  hl('@emphasis', p.fg, nil, 'italic')
  hl('@strike', p.fg, nil, 'strikethrough')
  li('@text', 'Fg')
  li('@math', 'Special')
  li('@environment', 'Macro')
  li('@environment.name', 'Type')
  li('@note', 'Information')
  li('@warning', 'Warning')
  li('@danger', 'Error')
  li('@conceal', 'Comment')

  -- LSP
  li('LspReferenceText', 'IdentifierUnderCaret')
  li('LspReferenceRead', 'IdentifierUnderCaret')
  li('LspReferenceWrite', 'IdentifierUnderCaretWrite')
  hl('LspInlayHint', p.inline_hint, nil, 'italic')
  li('LspCodeLens', 'LspInlayHint')
  li('LspCodeLensSeparator', 'LspCodeLens')
  li('LspSignatureActiveParameter', 'IncSearch')
  li('DiagnosticError', 'Error')
  li('DiagnosticWarn', 'Warning')
  li('DiagnosticInfo', 'Information')
  li('DiagnosticHint', 'Hint')
  hl('DiagnosticSignError', p.error_stripe, nil, 'bold')
  li('DiagnosticSignWarn', 'WarningSign')
  li('DiagnosticSignInfo', 'InformationSign')
  li('DiagnosticSignHint', 'HintSign')
  li('DiagnosticUnderlineError', 'ErrorUnderline')
  li('DiagnosticUnderlineWarn', 'WarnUnderline')
  li('DiagnosticUnderlineInfo', 'InfoUnderline')
  li('DiagnosticUnderlineHint', 'HintUnderline')
  li('DiagnosticFloatingError', 'NormalFloat')
  li('DiagnosticFloatingWarn', 'NormalFloat')
  li('DiagnosticFloatingInfo', 'NormalFloat')
  li('DiagnosticFloatingHint', 'NormalFloat')
  hl('DiagnosticOk', p.ansi_green, nil)
  hl('DiagnosticDeprecated', nil, nil, 'strikethrough')
  hl('DiagnosticUnnecessary', p.unused, nil, 'italic')
end

return M
