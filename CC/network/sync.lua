local M = {}

M.channel = 42
M.isPocket = pocket ~= nil
local modem = peripheral.find("modem")
if modem and not rednet.isOpen(peripheral.getName(modem)) then
    rednet.open(peripheral.getName(modem))
end

function M.send(data)
    if modem then
        rednet.broadcast(textutils.serialize(data), M.channel)
    end
end

function M.receive(timeout)
    if modem then
        local id, msg = rednet.receive(M.channel, timeout or 0.1)
        if msg then return textutils.unserialize(msg) end
    end
    return nil
end

return M