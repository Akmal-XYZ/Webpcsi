local ev = require('lib.samp.events')

local state = true

function main()
	sampRegisterChatCommand('antislap', function()
		state = not state
		if state then return sampAddChatMessage('Anti Slap diaktifkan', -1) end
		return sampAddChatMessage('Anti Slap dengan dinonaktifkan', -1)
	end)
	wait(-1)
end

function ev.onPlayerSync(id, data)
	if state then
		local x, y, z = getCharCoordinates(PLAYER_PED)
		if x - data.position.x > -1.5 and x - data.position.x < 1.5 then
			if (data.moveSpeed.x >= 1.5 or data.moveSpeed.x <= -1.5) or (data.moveSpeed.y >= 1.5 or data.moveSpeed.y <= -1.5) or (data.moveSpeed.z >= 0.5 or data.moveSpeed.z <= -0.5) then
				data.moveSpeed.x, data.moveSpeed.y, data.moveSpeed.z = 0, 0, 0
			end
		end
	end
	return {id, data}
end

function ev.onVehicleSync(id, vehid, data)
	if state then
		local x, y, z = getCharCoordinates(PLAYER_PED)
		if x - data.position.x > -1.5 and x - data.position.x < 1.5 then
			if (data.moveSpeed.x >= 1.5 or data.moveSpeed.x <= -1.5) or (data.moveSpeed.y >= 1.5 or data.moveSpeed.y <= -1.5) or (data.moveSpeed.z >= 0.5 or data.moveSpeed.z <= -0.5) then
				data.moveSpeed.x, data.moveSpeed.y, data.moveSpeed.z = 0, 0, 0
				data.position.x = data.position.x - 5
			end
		end
	end
	return {id, vehid, data}
end

-- function ev.onUnoccupiedSync(id, data)
-- 	if state then
-- 		local x, y, z = getCharCoordinates(PLAYER_PED)
-- 		if x - data.position.x > -1.5 and x - data.position.x < 1.5 then
-- 			if (data.moveSpeed.x >= 1.5 or data.moveSpeed.x <= -1.5) or (data.moveSpeed.y >= 1.5 or data.moveSpeed.y <= -1.5) or (data.moveSpeed.z >= 1.5 or data.moveSpeed.z <= -1.5) then
-- 				data.moveSpeed.x, data.moveSpeed.y, data.moveSpeed.z = 1, 1, 0
-- 				data.position.x = data.position.x - 5
-- 			end
-- 		end
-- 	end
-- 	return {tonumber(id), tonumber(data)}
-- end