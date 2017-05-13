local hyper = { "cmd", "alt", "ctrl", "shift" }

function cleanup_key()
  local app = hs.application.frontmostApplication()
  local name = app:name()
  if name == 'Mail' then
    if app:selectMenuItem("Hide Mailbox List") == nil then
      app:selectMenuItem("Show Mailbox List")
    end
    if app:selectMenuItem("Hide Toolbar") == nil then
      app:selectMenuItem("Show Toolbar")
    end
  else
    if app:selectMenuItem("Hide Toolbar") == nil then
      app:selectMenuItem("Show Toolbar")
    end
  end
end

hs.hotkey.bind(hyper, 'F16', cleanup_key)
