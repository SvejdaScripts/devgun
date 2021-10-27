local one = false
local two = false
local three = false
local owner = ''
local text = ''
local netID = ''
local entcoords = 0
local entcords2 = '~s~Coords : ~o~0'
local model = ''
local playerid = ''
local serverid = ''
local hit, entity
local text2 = '0'
local netID2 = '~s~Net ID: ~o~0'
local entcoords2 = 0
local model2 = '~s~Model: ~o~0'
local owner2 = '~s~Owner: ~o~0'
local playerid2 = 'PlayerID: '
local serverid2 = 'ServerID: '
local entity2 = '0'
local heading2 = '0'
local heading = '0'
local health = '~s~Health: ~o~'
local health_eng = '~s~Engine HP: ~o~'
local health_num = 0
local health_num_eng = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if one then
			hit, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
			if hit then
				entity2 = entity
				netID2 = netID
				model2 = model
				owner2 = owner		
				playerid2 = playerid
				serverid2 = serverid
				heading2 = heading
				health2 = health
				entcoords = GetEntityCoords(entity)
				entcords2 = '~s~Coords : ~o~' .. entcoords.x ..', ~g~' .. entcoords.y ..', ~b~' .. entcoords.z
				local jeNetworkovana = NetworkGetEntityIsNetworked(entity)
				if jeNetworkovana then
					netID = '~s~NetID: ~o~' .. ObjToNet(entity)
				else
					netID = '~s~NetID: ~r~NOT NETWORKED'
				end
				model = '~s~Model: ~o~' .. GetEntityModel(entity)
				heading = GetEntityHeading(entity)
				playerid = ''
				serverid = ''
				health_num = GetEntityHealth(entity)
				if  IsEntityAVehicle(entity) then
					health_num_eng = GetVehicleEngineHealth(entity)
				end
				if jeNetworkovana then
					local ownr = NetworkGetEntityOwner(entity)
					local ownrsid = GetPlayerServerId(ownr)
					if IsEntityAPed(entity) and IsPedAPlayer(entity) then
						playerid = NetworkGetPlayerIndexFromPed(entity) 
						serverid = GetPlayerServerId(playerid)
						text = '~s~EntityID: ~o~' .. entity .. '\n' .. model .. '\n' .. health.. '' ..health_num
						text2 = netID .. '\n' .. '~s~PlayerID: ~o~' .. playerid .. '\n~s~SID: ~o~' .. serverid
					elseif IsEntityAVehicle(entity) then
						local tank = GetVehiclePetrolTankHealth(entity)
						owner = '~s~Owner: ~o~' .. ownrsid
						text = '~s~EntityID: ~o~' .. entity .. '\n' .. model .. '\n' ..'~s~Body HP: ~o~'.. '' ..health_num
						text2 = '~s~Tank HP: ~o~'.. '' ..tank.. '\n' ..health_eng.. '' ..health_num_eng.. '\n' .. netID .. '\n'  .. owner
					else 
						owner = '~s~Owner: ~o~' .. ownrsid
						text = '~s~EntityID: ~o~' .. entity .. '\n' .. model .. '\n' .. health.. '' ..health_num
						text2 = netID .. '\n'  .. owner .. '\n' .. playerid 
					end
				else
					if IsEntityAVehicle(entity) then
						local tank = GetVehiclePetrolTankHealth(entity)
						owner = '~s~Owner: ~r~NOT NETWORKED'
						text = '~s~EntityID: ~o~' .. entity .. '\n' .. model .. '\n' ..'~s~Body HP: ~o~'.. '' ..health_num
						text2 = '~s~Tank HP: ~o~'.. '' ..tank.. '\n' ..health_eng.. '' ..health_num_eng.. '\n' .. netID .. '\n' .. playerid
					else
						owner = '~s~Owner: ~r~NOT NETWORKED'
						text = '~s~EntityID: ~o~' .. entity .. '\n' .. model .. '\n' .. health.. '' ..health_num
						text2 = netID .. '\n' .. playerid				
					end
				end
				DrawText3D(entcoords.x, entcoords.y, entcoords.z+0.70, '~s~Coords : ~o~' .. entcoords.x ..', ~g~' .. entcoords.y ..', ~b~' .. entcoords.z .. '\n~s~Heading: ~o~' .. heading, Config.Text3D.scale- 0.03, 255, 255, 255, 255)	
				DrawText3D(entcoords.x, entcoords.y, entcoords.z+0.45, text, Config.Text3D.scale, 255, 255, 255, 255) 
				DrawText3D(entcoords.x, entcoords.y, entcoords.z+0.08, text2, Config.Text3D.scale, 255, 255, 255, 255) 
			end
		end
	end
end)

RegisterCommand("dgentity", function()
	one = not one
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if two then
			local text = ''
			local netID = ''
			local entcoords = GetEntityCoords(ped)
			local netID = NetworkGetNetworkIdFromEntity(ped)
			local model = GetEntityModel(PlayerPedId())
			drawTxt(0.51, 0.782, 1.0,1.0,Config.Text2D.scale, '~y~Me', 255, 255, 255, 255, true)
			drawTxt(0.51, 0.8, 1.0,1.0,Config.Text2D.scale, '~s~Coords : ~o~' .. entcoords.x ..', ~g~' .. entcoords.y ..', ~b~' .. entcoords.z, 255, 255, 255, 255, true)
			drawTxt(0.51, 0.818, 1.0,1.0,Config.Text2D.scale, '~s~Heading: ~o~' ..  GetEntityHeading(PlayerPedId()), 255, 255, 255, 255, true)
			drawTxt(0.51, 0.836, 1.0,1.0,Config.Text2D.scale, '~s~EntityID: ~o~' .. ped, 255, 255, 255, 255, true)
			drawTxt(0.51, 0.872, 1.0,1.0,Config.Text2D.scale, '~s~Model: ~o~' .. model, 255, 255, 255, 255, true)
			drawTxt(0.51, 0.854, 1.0,1.0,Config.Text2D.scale, '~s~Net ID: ~o~' .. netID, 255, 255, 255, 255, true)		
			drawTxt(0.51, 0.890, 1.0,1.0,Config.Text2D.scale, '~s~PlayerID: ~o~' .. NetworkGetPlayerIndexFromPed(ped), 255, 255, 255, 255, true)
			drawTxt(0.51, 0.908, 1.0,1.0,Config.Text2D.scale, '~s~ServerID: ~o~' .. GetPlayerServerId(PlayerId()), 255, 255, 255, 255, true)
			drawTxt(0.51, 0.926, 1.0,1.0,Config.Text2D.scale, '~s~Health: ~o~' .. GetEntityHealth(PlayerPedId()), 255, 255, 255, 255, true)
		end
	end
end)

RegisterCommand("dgplayer", function()
	two = not two
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if three then
			drawTxt(0.51, 1.0, 1.0,1.0,Config.Text2D.scale, '~y~Target', 255, 255, 255, 255, true)
			drawTxt(0.51, 1.018, 1.0,1.0,Config.Text2D.scale, '' .. entcords2, 255, 255, 255, 255, true)
			drawTxt(0.51, 1.036, 1.0,1.0,Config.Text2D.scale, '~s~Heading: ~o~' .. heading2 , 255, 255, 255, 255, true)
			drawTxt(0.51, 1.054, 1.0,1.0,Config.Text2D.scale, '~s~Entity ID: ~o~' .. entity2, 255, 255, 255, 255, true)
			drawTxt(0.51, 1.072, 1.0,1.0,Config.Text2D.scale, '' .. model2, 255, 255, 255, 255, true)
			if NetworkGetEntityIsNetworked(entity2) then		
				if IsEntityAPed(entity2) and IsPedAPlayer(entity2) then
					drawTxt(0.51, 1.090, 1.0,1.0, Config.Text2D.scale, '~s~Health: ~o~' .. health_num, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.126, 1.0,1.0,Config.Text2D.scale, '~s~Player ID: ~o~' .. playerid2, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.144, 1.0,1.0,Config.Text2D.scale, '~s~Server ID: ~o~' .. serverid2, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.108, 1.0,1.0,Config.Text2D.scale, '' .. netID2, 255, 255, 255, 255, true)
				elseif  IsEntityAVehicle(entity2) then
					drawTxt(0.51, 1.090, 1.0,1.0,Config.Text2D.scale, '~s~Body Health: ~o~' .. health_num, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.126, 1.0,1.0,Config.Text2D.scale, '~s~Engine Health: ~o~' .. health_num_eng, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.108, 1.0,1.0,Config.Text2D.scale, '~s~Tank Health: ~o~' .. GetVehiclePetrolTankHealth(entity2), 255, 255, 255, 255, true)
					drawTxt(0.51, 1.162, 1.0,1.0,Config.Text2D.scale, '' .. owner2, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.144, 1.0,1.0,Config.Text2D.scale, '' .. netID2, 255, 255, 255, 255, true)
				else
					drawTxt(0.51, 1.090, 1.0,1.0, Config.Text2D.scale, '~s~Health: ~o~' .. health_num, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.126, 1.0,1.0,Config.Text2D.scale, '' .. owner2, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.108, 1.0,1.0,Config.Text2D.scale, '' .. netID2, 255, 255, 255, 255, true)
				end
			else
				if IsEntityAPed(entity2) then
					drawTxt(0.51, 1.108, 1.0,1.0,Config.Text2D.scale, '~s~Net ID: ~r~NOT NETWORKED', 255, 255, 255, 255, true)
					drawTxt(0.51, 1.090, 1.0,1.0, Config.Text2D.scale, '~s~Health: ~o~' .. health_num, 255, 255, 255, 255, true)
				elseif  IsEntityAVehicle(entity2) then
					drawTxt(0.51, 1.144, 1.0,1.0,Config.Text2D.scale, '~s~Net ID: ~r~NOT NETWORKED', 255, 255, 255, 255, true)
					drawTxt(0.51, 1.090, 1.0,1.0,Config.Text2D.scale, '~s~Body Health: ~o~' .. health_num, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.108, 1.0,1.0,Config.Text2D.scale, '~s~Engine Health: ~o~' .. health_num_eng, 255, 255, 255, 255, true)
					drawTxt(0.51, 1.126, 1.0,1.0,Config.Text2D.scale, '~s~Tank Health: ~o~' .. GetVehiclePetrolTankHealth(entity2), 255, 255, 255, 255, true)
				else
					drawTxt(0.51, 1.108, 1.0,1.0,Config.Text2D.scale, '~s~Net ID: ~r~NOT NETWORKED', 255, 255, 255, 255, true)
					drawTxt(0.51, 1.090, 1.0,1.0, Config.Text2D.scale, '~s~Health: ~o~' .. health_num, 255, 255, 255, 255, true)
				end
			end
		end	
	end
end)

RegisterCommand("dgcar", function()
	three = not three
end)

function DrawText3D(x, y, z, text, scale, r, g, b, a) 
    local onScreen, _x, _y = World3dToScreen2d(x, y, z) 
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) 
	local dist = #(vector3(pX,pY,pZ) - vector3(x,y,z))
	local scale = (1/dist)*2
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale * fov
	if onScreen then
		SetTextScale(0.0*scale, Config.Text3D.scalemulitplier*scale) 
		SetTextFont(Config.Text3D.font) 
		SetTextProportional(1) 
		SetTextEntry("STRING") 
		SetTextCentre(true) 
		SetTextOutline()
		SetTextColour(r, g, b, a) 
		AddTextComponentString(text) 
		DrawText(_x, _y) 
	end
end

function drawTxt(x,y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(Config.TextFont)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then SetTextOutline() end
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end
