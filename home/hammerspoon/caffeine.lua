caffeine_location = (os.getenv("HOME") .. "/iCloud/Internal/caffeine")

function startCaffeine(time)
  os.execute("/usr/bin/caffeinate -d -i -m -s -u -t " .. time .. " &")
  os.execute("say 'caffeine enabled'")
end

function caffeineCheck(files)
  for i,file in ipairs(files) do
    if file_exists(file) then
      startCaffeine(18000)
      os.remove(file)
    end
  end
end

function file_exists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

hs.pathwatcher.new(caffeine_location, caffeineCheck):start()
