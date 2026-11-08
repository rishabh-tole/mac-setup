-- two-finger horizontal swipe -> prev/next tab, Vivaldi only
-- loaded from init.lua. tweak THRESHOLD / RATIO below, then menu bar → Reload Config

local VIVALDI = "com.vivaldi.Vivaldi"
local THRESHOLD = 60      -- px of horizontal travel before it fires; raise if too twitchy
local RATIO = 2           -- horizontal must beat vertical by this much (avoids diagonal scrolls)

local P = hs.eventtap.event.properties
local vivaldiFront = false
local dx, dy, fired, swallowMomentum = 0, 0, false, false

-- track frontmost app (cheaper than checking on every scroll event)
local function checkFront()
  local app = hs.application.frontmostApplication()
  vivaldiFront = app ~= nil and app:bundleID() == VIVALDI
end
checkFront()
vivaldiTabSwipeAppWatcher = hs.application.watcher.new(function(_, ev, _)
  if ev == hs.application.watcher.activated then checkFront() end
end)
vivaldiTabSwipeAppWatcher:start()

local function switchTab(next)
  hs.timer.doAfter(0, function()
    if next then
      hs.eventtap.keyStroke({ "ctrl" }, "tab", 0)
    else
      hs.eventtap.keyStroke({ "ctrl", "shift" }, "tab", 0)
    end
  end)
end

vivaldiTabSwipeTap = hs.eventtap.new({ hs.eventtap.event.types.scrollWheel }, function(e)
  if not vivaldiFront then return false end
  if e:getProperty(P.scrollWheelEventIsContinuous) == 0 then return false end -- ignore real mouse wheels

  local phase    = e:getProperty(P.scrollWheelEventScrollPhase)
  local momentum = e:getProperty(P.scrollWheelEventMomentumPhase)

  -- eat the coast-after-lift if this gesture already switched tabs
  if momentum ~= 0 then return swallowMomentum end

  if phase == 1 or phase == 128 then        -- began / may-begin
    dx, dy, fired, swallowMomentum = 0, 0, false, false
  end

  dx = dx + e:getProperty(P.scrollWheelEventPointDeltaAxis2)
  dy = dy + e:getProperty(P.scrollWheelEventPointDeltaAxis1)

  if not fired and math.abs(dx) > THRESHOLD and math.abs(dx) > RATIO * math.abs(dy) then
    fired, swallowMomentum = true, true
    switchTab(dx < 0)                        -- flip to (dx > 0) if direction feels backwards
  end

  return fired                               -- once fired, swallow rest of the gesture
end)
vivaldiTabSwipeTap:start()
