local M = { }
local editing, run = textadept.editing, textadept.run
editing.comment_string.moonscript = '--'
run.run_commands.moon = 'moonc -p %(filename)'
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
  for _index_0 = 1, #control_structure_patterns do
    local patt = control_structure_patterns[_index_0]
    if line:find(patt) then
      indent = line_indentation[line_num]
      buffer:begin_undo_action()
      buffer:new_line()
      line_indentation[line_num + 1] = indent + buffer.tab_width
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
      module_file
    }
  },
  ['\n'] = indent
}
return M
