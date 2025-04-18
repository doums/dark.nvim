-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

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
  vim.api.nvim_set_hl(0, name, hl_map)
end

local function li(target, source)
  vim.api.nvim_set_hl(0, target, { link = source })
end

local function clear(group)
  vim.api.nvim_set_hl(0, group, {})
end

function M.init()
  --[[ The CursorLine background will be overloaded by any group
  that defines a background value.
  Do not link to Normal group. Instead, link to this group.
  see https://github.com/neovim/neovim/issues/9019 ]]
  hl('Fg', p.fg)

  -- helper groups
  hl('Bold', nil, nil, 'bold')
  hl('Italic', nil, nil, 'italic')
  hl('Underline', nil, nil, 'underline')
  hl('Strikethrough', nil, nil, 'strikethrough')
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
  li('ErrorMsg', 'Error')
  -- TODO deprecated, to be removed
  hl('VertSplit', p.comment)
  hl('WinSeparator', p.ui_frame_fg)
  hl('Folded', p.folded_fg, p.folded_bg)
  hl('FoldColumn', p.comment)
  hl('SignColumn', nil, nil)
  hl('IncSearch', nil, p.inc_search)
  li('CurSearch', 'IncSearch')
  li('Substitute', 'Search')
  hl('LineNr', p.line_nr)
  -- LineNrAbove
  -- LineNrBelow
  hl('CursorLineNr', p.constant, nil, 'bold')
  -- CursorLineFold
  -- CursorLineSign
  hl('MatchParen', nil, p.match_brace)
  hl('ModeMsg', p.std_output)
  li('MsgArea', 'Fg')
  li('MsgSeparator', 'StatusLine')
  li('MoreMsg', 'Fg')
  hl('NonText', p.comment)
  hl('Normal', p.fg, p.bg)
  li('NormalFloat', 'Pmenu')
  hl('FloatBorder', p.fg, p.menu)
  li('FloatTitle', 'Todo')
  li('FloatFooter', 'Comment')
  li('NormalNC', 'Fg')
  hl('Pmenu', p.fg, p.menu)
  hl('PmenuSel', nil, p.menu_sel)
  -- PmenuKind
  -- PmenuKindSel
  -- PmenuExtra
  -- PmenuExtraSel
  hl('PmenuSbar', p.menu, p.menu)
  hl('PmenuThumb', p.menu_thumb, p.menu_thumb)
  -- PmenuMatch
  -- PmenuMatchSel
  li('ComplMatchIns', 'IdentifierUnderCaret')
  li('Question', 'Fg')
  hl('QuickFixLine', nil, p.selection)
  hl('Search', nil, p.search)
  -- SnippetTabstop
  li('SpecialKey', 'NonText')
  hl('SpellBad', nil, nil, 'underdashed', p.typo)
  li('SpellCap', 'SpellBad')
  li('SpellLocal', 'SpellBad')
  li('SpellRare', 'SpellBad')
  hl('StatusLine', p.fg, p.ui_frame_bg)
  hl('StatusLineNC', p.ui_frame_fg, p.bg)
  -- StatusLineTerm
  -- StatusLineTermNC
  hl('TabLine', p.ui_frame_fg, p.bg)
  hl('TabLineFill', p.ui_frame_bg, p.bg)
  hl('TabLineSel', p.fg, p.ui_frame_bg)
  li('Title', 'Special')
  hl('Visual', nil, p.selection)
  li('VisualNOS', 'Visual')
  li('WarningMsg', 'Warning')
  li('Whitespace', 'NonText')
  li('WildMenu', 'PmenuSel')
  li('WinBar', 'StatusLine')
  li('WinBarNC', 'StatusLineNC')

  -- common groups `:h group-name`
  hl('Comment', p.comment, nil, 'italic')
  hl('Constant', p.constant, nil, { 'italic', 'bold' })
  hl('String', p.string)
  li('Character', 'String')
  hl('Number', p.number)
  li('Boolean', 'Keyword')
  li('Float', 'Number')
  li('Identifier', 'Fg')
  hl('Function', p['function'])
  li('Statement', 'Keyword')
  li('Conditional', 'Keyword')
  li('Repeat', 'Keyword')
  li('Label', 'Keyword')
  li('Operator', 'Keyword')
  hl('Keyword', p.keyword)
  li('Exception', 'Keyword')
  hl('PreProc', p.metadata)
  li('Include', 'PreProc')
  li('Define', 'PreProc')
  li('Macro', 'PreProc')
  li('PreCondit', 'PreProc')
  li('Type', 'Keyword')
  li('StorageClass', 'Keyword')
  li('Structure', 'Keyword')
  li('Typedef', 'Keyword')
  li('Special', 'Keyword')
  li('SpecialChar', 'Keyword')
  hl('Tag', p.tag)
  li('Delimiter', 'Keyword')
  hl('SpecialComment', p.comment_doc, nil, 'italic')
  hl('Debug', p.debug, nil, 'italic')
  hl('Underlined', p.fg, nil, 'underline')
  -- Ignore
  -- Error defined above
  hl('Todo', p.todo, nil, { 'bold', 'italic' })
  li('Added', 'DiffAdd')
  li('Changed', 'DiffChange')
  li('Removed', 'DiffDelete')

  -- some other groups
  li('healthSuccess', 'IncSearh')
  hl('NvimInternalError', p.error, p.error)
  hl('RedrawDebugClear', p.fg, p.duplicate_from_server)
  hl('RedrawDebugComposed', p.fg, p.search)
  li('RedrawDebugRecompose', 'Error')

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

  -- Treesitter (:h treesitter-highlight-groups)
  hl('@macro', p.macro)
  hl('@shebang', p.macro, nil, 'italic')
  li('@variable', 'Fg')
  hl('@variable.builtin', p.constant, nil, 'italic')
  li('@variable.parameter', '@variable')
  li('@variable.parameter.builtin', '@variable.builtin')
  hl('@variable.member', p.constant)
  hl('@constant', p.constant, nil, 'italic')
  hl('@constant.builtin', p.constant, nil, { 'bold', 'italic' })
  li('@constant.macro', '@macro')
  li('@module', 'Fg')
  hl('@module.builtin', p.c_identifier, nil, 'italic')
  hl('@label', p.label, nil, 'italic')
  li('@string', 'String')
  hl('@string.documentation', p.comment_doc)
  hl('@string.regexp', p.regex)
  li('@string.escape', 'Keyword')
  hl('@string.special', p.string_special)
  li('@string.special.symbol', '@string.special')
  li('@string.special.path', '@string.special')
  li('@string.special.url', 'Underline')
  li('@character', 'String')
  li('@character.special', 'Keyword')
  li('@number', 'Number')
  li('@number.float', '@number')
  li('@type', 'Fg')
  li('@type.builtin', 'Keyword')
  li('@type.definition', 'Fg')
  li('@attribute', '@label')
  li('@attribute.builtin', '@attribute')
  li('@property', '@variable.member')
  li('@property.toml', 'Keyword')
  li('@function', 'Function')
  hl('@function.builtin', p.instance_method, nil, 'italic')
  li('@function.call', 'Fg')
  li('@function.macro', '@macro')
  hl('@function.method', p.instance_method)
  li('@function.method.call', '@function.method')
  li('@constructor', '@function')
  li('@operator', 'Fg')
  li('@keyword', 'Keyword')
  li('@keyword.import', 'Keyword')
  li('@keyword.import.c', 'PreProc')
  li('@keyword.import.cpp', 'PreProc')
  li('@keyword.import.zig', '@function.builtin')
  li('@keyword.conditional.ternary', 'Fg')
  li('@keyword.directive', 'PreProc')
  li('@keyword.directive.sh', '@shebang')
  li('@keyword.directive.bash', '@shebang')
  li('@keyword.directive.fish', '@shebang')
  li('@keyword.directive.nu', '@shebang')
  li('@punctuation.delimiter', 'Fg')
  li('@punctuation.bracket', 'Fg')
  li('@punctuation.special', 'Keyword')
  hl('@comment', p.comment)
  li('@comment.yaml', '@comment.documentation')
  hl('@comment.documentation', p.comment_doc, nil, 'italic')
  hl('@comment.error', p.error, nil, 'bold')
  hl('@comment.warning', p.warning, nil, 'bold')
  li('@comment.todo', 'Todo')
  hl('@comment.note', p.info_effect, nil, 'bold')
  li('@markup.heading', '@constant')
  hl('@markup.heading.1', p.constant, nil, { 'bold', 'italic' })
  li('@markup.quote', 'Comment')
  hl('@markup.link', p['function'], nil, 'underline')
  hl('@markup.link.url', p['function'], nil, { 'italic', 'underline' })
  li('@markup.raw', 'String')
  li('@conceal.markdown_inline', 'Conceal')
  hl('@tag', p.tag)
  li('@tag.builtin', '@tag')
  hl('@tag.attribute', p.fg)
  li('@tag.delimiter', '@tag')

  -- LSP
  li('LspReferenceText', 'IdentifierUnderCaret')
  li('LspReferenceRead', 'IdentifierUnderCaret')
  li('LspReferenceWrite', 'IdentifierUnderCaretWrite')
  li('LspReferenceTarget', 'LspReferenceText')
  hl('LspInlayHint', p.inline_hint, nil, 'italic')
  li('LspCodeLens', 'LspInlayHint')
  li('LspCodeLensSeparator', 'LspCodeLens')
  li('LspSignatureActiveParameter', 'IncSearch')

  -- WIP LSP SEMANTIC (:h lsp-semantic-highlight)
  clear('@lsp.type.comment') -- TS query is better
  clear('@lsp.type.variable')
  clear('@lsp.type.function')
  clear('@lsp.type.method')
  li('@lsp.typemod.function.declaration', '@function')
  li('@lsp.typemod.function.associated', '@function.builtin')
  hl('@lsp.type.typeParameter', p.type_parameter)
  hl('@lsp.type.decorator', p.metadata)
  li('@lsp.type.attributeBracket', '@lsp.type.decorator')
  hl('@lsp.type.macro', p.macro)
  li('@lsp.type.procMacro', '@lsp.type.macro')
  li('@lsp.type.variable.member', '@field')
  li('@lsp.typemod.selfKeyword', 'Italic')
  li('@lsp.mod.static', 'Italic')

  -- Diagnostic
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
  li('DiagnosticDeprecated', 'Strikethrough')
  hl('DiagnosticUnnecessary', p.unused)
end

return M
