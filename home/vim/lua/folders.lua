-- Borrowed from https://github.com/jamestthompson3/vimConfig/

local home = os.getenv("HOME")

--- Check if a file or directory exists in this path
function exists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

--- Check if a directory exists in this path
function isdir(path)
  -- "/" works on both Unix and Windows
  return exists(path.."/")
end

local function create_backup_dir()
  local data_dir   = home .. '/.local/share/nvim/'
  local backup_dir = data_dir .. 'backup'
  local undo_dir   = data_dir .. 'undo'
  if not isdir(data_dir) then
    os.execute("mkdir " .. data_dir)
  end
  if not isdir(backup_dir) then
    os.execute("mkdir " .. backup_dir)
  end
  if not isdir(undo_dir) then
    os.execute("mkdir " .. undo_dir)
  end
end

create_backup_dir()

if os.getenv("SUDO_USER") then
  vim.o.backup      = false
  vim.o.writebackup = false
  vim.o.swapfile    = false
  vim.o.undofile    = false
else
  vim.o.backupdir   = home .. "/.local/share/nvim/backup"
  vim.o.undofile    = true
  vim.o.backup      = true
  vim.o.writebackup = true
  vim.o.swapfile    = true
  vim.bo.undofile   = true
  vim.bo.swapfile   = true
end
