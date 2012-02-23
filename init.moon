-- A `moonscript` module for the
-- [Textadept](http://code.google.com/p/textadept/) editor.
-- It provides utilities for editing
-- [Moonscript](http://moonscript.org) code.<br>
--
-- The source is on
-- [GitHub](https://github.com/rgieseke/ta-moonscript),
-- released under the
-- [MIT license](http://www.opensource.org/licenses/mit-license.php).

M = {}

m_editing, m_run = _M.textadept.editing, _M.textadept.run

-- Comment string (uses lexer name).
m_editing.comment_string.moonscript = '-- '

-- Run command (uses file extension).
m_run.run_command.moon = 'moonc -p %(filename)'

-- Set default buffer properties.
M.set_buffer_properties = ->
  return

-- Control structures after which indentation should be increased.
control_structure_patterns = {
  '^%s*class',
  '^%s*[%w_]*%s?=?%s?for',
  '^%s*if',
  '^%s*else',
  '^%s*[%w_]*%s?=?%s?switch',
  '^%s*when',
  '^%s*while',
  '[%-=]>[\r\n]$',
}

-- Increase indentation level after new line if line contains `class`,
-- `for`, etc., but only if at the end of a line.
indent = ->
  buffer = buffer
  if buffer\auto_c_active! then return false
  current_pos = buffer.current_pos
  line_num = buffer\line_from_position(current_pos)
  col = buffer.column[current_pos]
  if col == 0 or buffer.current_pos ~= buffer.line_end_position[line_num]
    return false
  line = buffer\get_line(line_num)
  line_indentation = buffer.line_indentation
  for patt in *control_structure_patterns do
    if line\find(patt)
      indent = line_indentation[line_num]
      buffer\begin_undo_action!
      buffer\new_line!
      line_indentation[line_num + 1] = indent + buffer.indent
      buffer\line_end!
      buffer\end_undo_action!
      return true
  return false

-- Moonscript snippets
snippets.moonscript = {
  p: 'print',
  s: 'switch %1\n\twhen %0',
}

-- Key commands.
module_file = _USERHOME..'/modules/moonscript/init.moon'
keys.moonscript = {
  [keys.LANGUAGE_MODULE_PREFIX]: {
    m: {io.open_file, module_file\iconv('UTF-8', _CHARSET) },
    },
  ['\n']: indent,
}

return M
