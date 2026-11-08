-- right-click drag left/right -> prev/next tab, Vivaldi only
-- trackpad: two-finger click, hold, slide. mouse: hold right button, drag
-- plain right click (no drag) still opens the context menu
-- tweak THRESHOLD / RATIO, save -> auto reloads

local VIVALDI   = "com.vivaldi.Vivaldi"
local THRESHOLD = 40   -- px of horizontal drag before it fires
local RATIO     = 1.5  -- horizontal must beat vertical by this much
local MARK      = 0x7AB5 -- tags our own replayed clicks so the tap ignores them

local T = hs.eventtap.event.types
local P = hs.eventtap.event.properties

local active, fired, start = false, false, nil

local function vivaldiFront()
  local app = hs.application.frontmostApplication()
  return app ~= nil and app:bundleID() == VIVALDI
end

local function switchTab(next)
  hs.timer.doAfter(0, function()
    if next then
      hs.eventtap.keyStroke({ "ctrl" }, "tab", 0)
    else
      hs.eventtap.keyStroke({ "ctrl", "shift" }, "tab", 0)
    end
  end)
end

-- re-send a normal right click at `pos` (we swallowed the original down)
local function replayRightClick(pos)
  local down = hs.eventtap.event.newMouseEvent(T.rightMouseDown, pos)
  local up   = hs.eventtap.event.newMouseEvent(T.rightMouseUp, pos)
  down:setProperty(P.eventSourceUserData, MARK)
  up:setProperty(P.eventSourceUserData, MARK)
  hs.timer.doAfter(0, function() down:post(); up:post() end)
end

vivaldiRightDragTap = hs.eventtap.new(
  { T.rightMouseDown, T.rightMouseDragged, T.rightMouseUp },
  function(e)
    if e:getProperty(P.eventSourceUserData) == MARK then return false end
    local t = e:getType()

    if t == T.rightMouseDown then
      if not vivaldiFront() then active = false; return false end
      active, fired, start = true, false, e:location()
      return true -- hold it until we know if it's a click or a drag
    end

    if not active then return false end

    if t == T.rightMouseDragged then
      if not fired then
        local p = e:location()
        local dx, dy = p.x - start.x, p.y - start.y
        if math.abs(dx) > THRESHOLD and math.abs(dx) > RATIO * math.abs(dy) then
          fired = true
          switchTab(dx > 0) -- drag right = next tab, left = prev
        end
      end
      return true
    end

    if t == T.rightMouseUp then
      active = false
      if not fired then replayRightClick(start) end
      return true
    end

    return false
  end
)
vivaldiRightDragTap:start()

-- macOS kills slow taps silently; keep it alive
vivaldiRightDragWatchdog = hs.timer.doEvery(5, function()
  if not vivaldiRightDragTap:isEnabled() then vivaldiRightDragTap:start() end
end)
