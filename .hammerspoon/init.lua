local module = {}
local log = hs.logger.new("test.mouse", "debug")

-- -- local mouseEvent = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
-- module.modifierListener = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
--   hs.alert.show(event:getKeyCode())
--   -- if event:getKeyCode() == rightCommandKeyCode then --   local eventData = event:getRawEventData().NSEventData
--   --   if (eventData.modifierFlags & rightCommandFlag) == rightCommandFlag then
--   --     module.keyListener = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, rightCommandHandler):start()
--   --   elseif module.keyListener and (eventData.modifierFlags & releasedFlag) == releasedFlag then
--   --     module.keyListener:stop()
--   --     module.keyListener = nil
--   --   end
--   -- end
-- end):start

module.modifierListener = hs.eventtap.new({hs.eventtap.event.types.leftMouseUp}, function(event)
  -- log.d('lef mouse up')
  -- log.v(event)
end):start()

module.modifierListener = hs.eventtap.new({hs.eventtap.event.types.otherMouseUp}, function(event)
  -- for key, val in pairs(event:systemKey()) do
  --   log.d(key, val)
  -- end
  -- hs.eventtap.keyStroke({"NEXT"}, "")
  log.d('other mouse up')
  -- hs.eventtap.event.newSystemKeyEvent('NEXT', true):post()
  -- hs.eventtap.event.newSystemKeyEvent('NEXT', true):post()
end):start()

-- module.modifierListener = hs.eventtap.new({hs.eventtap.event.types.otherMouseUp}, function(event)
--   log.d('other mouse up')
--   -- local info = {}
-- 
--   -- -- @link http://www.hammerspoon.org/docs/hs.eventtap.event.html#properties
--   -- for key, val in pairs(hs.eventtap.event.properties) do
--   --   log.d(key, val)
-- 
--   -- -- @link http://www.hammerspoon.org/docs/hs.eventtap.event.html#systemKey
--   -- hs.eventtap.event:systemKey()
-- 
--   log.d(event:getProperty(hs.eventtap.event.properties.mouseEventInstantMouser))
-- 
--   -- log.d(event)
--   -- log.v(hs.mouse.getButtons)
--   for key, val in pairs(hs.mouse.getButtons()) do
--     log.d(key, val)
--   end
-- end):start()

module.modifierListener = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
  -- log.d(event:getKeyCode())

  -- hs.logger
  -- if event:getKeyCode() == rightCommandKeyCode then
  --   local eventData = event:getRawEventData().NSEventData
  --   if (eventData.modifierFlags & rightCommandFlag) == rightCommandFlag then
  --     module.keyListener = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, rightCommandHandler):start()
  --   elseif module.keyListener and (eventData.modifierFlags & releasedFlag) == releasedFlag then
  --     module.keyListener:stop()
  --     module.keyListener = nil
  --   end
  -- end
end):start()


-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--   hs.alert.show("Hello World!")
-- end)

--
-- local log = hs.logger.new("test.mouse", "debug")
-- 
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--   hs.alert.show("Hello World!")
--   log.d("hello world")
-- end)
-- 
