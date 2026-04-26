local A = vim.api

local function get_region(opmode)
  if not opmode then
    local row = unpack(A.nvim_win_get_cursor(0))
    return { srow = row, scol = 0, erow = row, ecol = 0 }
  end

  local marks = string.match(opmode, '[vV]') and { '<', '>' } or { '[', ']' }
  local sln, eln = A.nvim_buf_get_mark(0, marks[1]), A.nvim_buf_get_mark(0, marks[2])

  return { srow = sln[1], scol = sln[2], erow = eln[1], ecol = eln[2] }
end

local function get_lines(range)
  if range.srow == range.erow then
    return { A.nvim_get_current_line() }
  end

  return A.nvim_buf_get_lines(0, range.srow - 1, range.erow, false)
end

local function grab_string(motion)
  local range = get_region(motion)
  local text = ""

  if motion == "char" then
    text = table.concat(
      vim.api.nvim_buf_get_text(0, (range.srow - 1), range.scol, (range.erow - 1), (range.ecol + 1), {}), "")
  elseif motion == "line" then
    text = table.concat(get_lines(range), "")
  else
    Notifier("something very weird happened with the operator stuff")
  end

  return text
end

function _G.op_google(motion)
  Google(grab_string(motion), false)
end

function _G.op_google_lucky(motion)
  Google(grab_string(motion), true)
end

s_nmap("??", "<ESC><CMD>set operatorfunc=v:lua.op_google<CR>g@", {}, "Google search [motion]")
s_nmap("?!", "<ESC><CMD>set operatorfunc=v:lua.op_google_lucky<CR>g@", {}, "Feelin' lucky search [motion]")

s_nmap("<leader>y", [[+y]], {}, "copy to system clipboard")

