local M = {}

function M.printErrGo()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = { 'if err != nil {', '\tfmt.Println("Error: ", err)', '\treturn', '}' }

  for _, line in ipairs(lines) do
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, true, { line })
    row = row + 1
  end
end

return M
