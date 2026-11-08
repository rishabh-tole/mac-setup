-- Hammerspoon config. Linked to ~/.hammerspoon by mac_config.sh

require("vivaldi-rightdrag") -- right-click drag left/right = prev/next tab in Vivaldi

-- auto reload on any .lua save
hsConfigWatcher = hs.pathwatcher.new(hs.configdir, function(files)
  for _, f in ipairs(files) do
    if f:sub(-4) == ".lua" then hs.reload(); return end
  end
end):start()

if not hs.accessibilityState() then
  hs.alert.show("Hammerspoon needs Accessibility: System Settings → Privacy & Security → Accessibility", 6)
else
  hs.alert.show("Hammerspoon config loaded")
end
