#!/usr/bin/env ruby -U

require 'fileutils'

# @type = ARGV[0] == 'NU' ? 'red' : 'green'
@type = "green"

def set_wallpaper source
  system "osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"#{source}\"'"
end

def convert_wallpaper source, result
  system %Q(/usr/local/bin/convert "#{source}" -fill #{@type} -tint 90 #{result})
end

wallpaper        = `osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)'`.gsub("\n",'')
cached_wallpaper = "#{ENV['HOME']}/Documents/temp/wallpaper.png"
vpn_wallpaper    = "#{ENV['HOME']}/Documents/temp/#{@type}_vpn.png"

FileUtils.cp(wallpaper, cached_wallpaper) unless wallpaper == cached_wallpaper
convert_wallpaper(wallpaper, vpn_wallpaper)

set_wallpaper(vpn_wallpaper)
