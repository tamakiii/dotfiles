local module = {}
local log = hs.logger.new("test.mouse", "debug")


-- left upper button =>
-- hs.eventtap.event.types.keyUp
-- 2017-09-11 14:48:09:                          123
--
-- right upper button =>
-- hs.eventtap.event.types.keyUp
-- 2017-09-11 14:48:57:                          124
--
-- upper buttons =>
-- hs.eventtap.event.types.keyUp
-- 2017-09-11 14:49:16:                          126
--
-- lower buttons =>
-- unknown

module[1] = hs.eventtap.new({hs.eventtap.event.types.otherMouseUp}, function(event)
  log.d('hs.eventtap.event.types.otherMouseUp')
  for key, val in pairs(hs.mouse.getButtons()) do
    log.d(key, val)
  end
end):start()

module[2] = hs.eventtap.new({hs.eventtap.event.types.keyUp}, function(event)
  log.d('hs.eventtap.event.types.keyUp')
  log.d(event:getKeyCode())
end):start()

