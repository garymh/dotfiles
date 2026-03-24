local TOKEN_FILE = os.getenv("HOME")
  .. "/Library/Mobile Documents/com~apple~CloudDocs/Internal/private/private.zsh"
local HA_URL = "http://homeassistant.local:8123/api/states/binary_sensor.workday_sensor"

local function readToken()
  local f = io.open(TOKEN_FILE, "r")
  if not f then return nil end
  for line in f:lines() do
    local token = line:match("^export%s+HA_TOKEN=[\"']?(.-)[\"']?$")
      or line:match("^HA_TOKEN=[\"']?(.-)[\"']?$")
    if token then
      f:close()
      return token
    end
  end
  f:close()
  return nil
end

local function openSwiftBar()
  local token = readToken()
  if not token then
    print("[swiftbar] could not read HA_TOKEN from " .. TOKEN_FILE)
    return
  end

  local headers = {
    ["Authorization"] = "Bearer " .. token,
    ["Content-Type"] = "application/json",
  }

  hs.http.asyncGet(HA_URL, headers, function(status, body, _)
    if status ~= 200 then
      print("[swiftbar] API returned status " .. tostring(status))
      return
    end

    local data = hs.json.decode(body)
    if data and data.state == "on" then
      print("[swiftbar] workday sensor is on, opening SwiftBar")
      hs.application.open("SwiftBar")
    else
      print("[swiftbar] workday sensor is off, skipping")
    end
  end)
end

local function closeSwiftBar()
  local app = hs.application.find("SwiftBar")
  if app then
    print("[swiftbar] closing SwiftBar")
    app:kill()
  end
end

hs.timer.doAt("09:00", "01d", openSwiftBar, true)
hs.timer.doAt("17:00", "01d", closeSwiftBar, true)
