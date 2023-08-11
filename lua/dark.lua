-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

local p = require('dark.palette')
local hl = require('dark.hl')

local function load()
  if vim.fn.has('termguicolors') ~= 1 then
    vim.api.nvim_echo({
      { '[dark] needs truecolor support (see :h termguicolors).' },
    }, true, {})
    return
  end

  if vim.g.colors_name then
    vim.cmd('hi clear')
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'dark'

  -- generate highlight groups
  hl.init()
end

M.p = p
M.load = load
return M
