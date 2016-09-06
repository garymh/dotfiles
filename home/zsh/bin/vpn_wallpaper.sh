#!/usr/bin/env ruby -U

require 'fileutils'

def set_wallpaper source
  system "osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"#{source}\"'"
end

def convert_wallpaper source, result
  system %Q(/usr/local/bin/convert "#{source}" -fill red -tint 90 #{result})
end

wallpaper        = `osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)'`.gsub("\n",'')
cached_wallpaper = "#{ENV['HOME']}/Documents/wallpaper.png"
vpn_wallpaper    = "#{ENV['HOME']}/Documents/vpn.png"

if !File.exist?(cached_wallpaper) || File.size(wallpaper) != File.size(cached_wallpaper)
  FileUtils.cp(wallpaper, cached_wallpaper)
  convert_wallpaper(wallpaper, vpn_wallpaper)
end

set_wallpaper(vpn_wallpaper)
