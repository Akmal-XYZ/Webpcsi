local events = require 'lib.samp.events'

local nolic = false

function events.onRemovePlayerFromVehicle() if nolic then return false end end

function events.onSetPlayerPos() if nolic then return false end end

function events.onServerMessage(c, m)
	local mes1 = 'Вы не можете управлять транспортом без прав'
	local mes2 = 'Это служебный транспорт, вы не можете им управлять'
	if nolic and (m:find(mes1) or m:find(mes2)) then return false end
end

local notInCarYet = true
local firstTimeSitInCar = 0

function events.onSendPlayerSync() notInCarYet = true end

function events.onSendVehicleSync()
	if notInCarYet then firstTimeSitInCar = os.clock(); notInCarYet = false end
end

function main()
	while not isSampAvailable() do wait(100) end
	sampRegisterChatCommand('nolic', function ()
		nolic = not nolic
		sampAddChatMessage('LUA: Чит на езду без прав ' .. (nolic and '{00AA00}включен' or '{AA0000}выключен') .. '{007FFF}.', 0x007FFF)
	end)
	while true do
		wait(2000)
		if nolic and isCharInAnyCar(1) and ((os.clock() - firstTimeSitInCar) > 1) then
			sampForceOnfootSync()
			sampSendEnterVehicle(select(2, sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(1))))
		end
	end
end






function sendFakeOnfootSync(x, y, z)
	local data = allocateMemory(68)
	
	setStructElement(data, 0, 2, 0, false)
	setStructElement(data, 2, 2, 0, false)
	setStructElement(data, 4, 2, 0, false)
	
	setStructFloatElement(data, 6, x, false)
	setStructFloatElement(data, 10, y, false)
	setStructFloatElement(data, 14, z, false)
	
	setStructFloatElement(data, 18, 0, false)
	setStructFloatElement(data, 22, 0, false)
	setStructFloatElement(data, 26, 0, false)
	setStructFloatElement(data, 30, 0, false)
	
	setStructElement(data, 34, 1, getCharHealth(PLAYER_PED), false)
	setStructElement(data, 35, 1, 0, false)
	setStructElement(data, 36, 1, 0, false)
	setStructElement(data, 37, 1, 0, false)
	
	setStructFloatElement(data, 38, 0, false)
	setStructFloatElement(data, 42, 0, false)
	setStructFloatElement(data, 46, 0, false)
	
	setStructFloatElement(data, 50, 0, false)
	setStructFloatElement(data, 54, 0, false)
	setStructFloatElement(data, 58, 0, false)
	
	setStructElement(data, 62, 2, 0, false)
	setStructElement(data, 64, 2, 1198, false)
	setStructElement(data, 66, 2, 0, false)
	
	sampSendOnfootData(data)
	freeMemory(data)
end