local M = { }
local m_editing, m_run = _M.textadept.editing, _M.textadept.run
m_editing.comment_string.moonscript = '-- '
m_run.run_command.moon = 'moonc -p %(filename)'
M.set_buffer_properties = function()
  return 
end
local control_structure_patterns = {
  '^%s*class',
  '^%s*[%w_]*%s?=?%s?for',
  '^%s*if',
  '^%s*else',
  '^%s*[%w_]*%s?=?%s?switch',
  '^%s*when',
  '^%s*while',
  '[%-=]>[\r\n]$'
}
local indent
indent = function()
  local buffer = buffer
  if buffer:auto_c_active() then
    return false
  end
  local current_pos = buffer.current_pos
  local line_num = buffer:line_from_position(current_pos)
  local col = buffer.column[current_pos]
  if col == 0 or buffer.current_pos ~= buffer.line_end_position[line_num] then
    return false
  end
  local line = buffer:get_line(line_num)
  local line_indentation = buffer.line_indentation
  local _list_0 = control_structure_patterns
  for _index_0 = 1, #_list_0 do
    local patt = _list_0[_index_0]
    if line:find(patt) then
      indent = line_indentation[line_num]
      buffer:begin_undo_action()
      buffer:new_line()
      line_indentation[line_num + 1] = indent + buffer.indent
      buffer:line_end()
      buffer:end_undo_action()
      return true
    end
  end
  return false
end
snippets.moonscript = {
  p = 'print',
  s = 'switch %1\n\twhen %0'
}
local module_file = _USERHOME .. '/modules/moonscript/init.moon'
keys.moonscript = {
  [keys.LANGUAGE_MODULE_PREFIX] = {
    m = {
      io.open_file,
      module_file:iconv('UTF-8', _CHARSET)
    }
  },
  ['\n'] = indent
}
return M
