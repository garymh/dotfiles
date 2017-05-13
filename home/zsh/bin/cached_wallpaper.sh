#!/usr/bin/env ruby -U

require 'fileutils'

def set_wallpaper source
  system "osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"#{source}\"'"
end

cached_wallpaper = "#{ENV['HOME']}/Documents/temp/wallpaper.png"

set_wallpaper(cached_wallpaper)

