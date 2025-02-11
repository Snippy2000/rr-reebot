DecoMode = false
local MainCamera = nil
local curPos
local speeds = {0.05, 0.1, 0.2, 0.4, 0.5}
local curSpeed = 1

local cursorEnabled = true

local SelectedObj = nil
local SelObjHash = {}
local SelObjPos = {}
local SelObjRot = {}

local curRotate = {}

local ObjectList = {}
local SelObjId = 0

local isEdit = false

local rotateActive = false
local peanut = false

local previewObj = nil
-- Only enable some controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if DecoMode then
			DisableAllControlActions(0)
			EnableControlAction(0, Keys["W"], true)
			EnableControlAction(0, Keys["S"], true)
			EnableControlAction(0, Keys["T"], true)
			EnableControlAction(0, Keys["LEFTSHIFT"], true)
			EnableControlAction(0, Keys["LEFTALT"], true)
			EnableControlAction(0, Keys["F1"], true)
            EnableControlAction(0, Keys["F2"], true)
            EnableControlAction(0, Keys["F3"], true)
			EnableControlAction(0, Keys["ENTER"], true)
			EnableControlAction(0, Keys["LEFT"], true)
			EnableControlAction(0, Keys["RIGHT"], true)
			EnableControlAction(0, Keys["TOP"], true)
			EnableControlAction(0, Keys["DOWN"], true)
			EnableControlAction(0, Keys["PAGEUP"], true)
            EnableControlAction(0, Keys["PAGEDOWN"], true)
            EnableControlAction(0, Keys["BACKSPACE"], true)

			DisplayRadar(false)

			CheckRotationInput()
            CheckMovementInput()
            
            if SelectedObj ~= nil and peanut then
                DrawMarker(21, SelObjPos.x, SelObjPos.y, SelObjPos.z + 1.28, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.6, 0.6, 0.6, 28, 149, 255, 100, true, true, 2, false, false, false, false)
                if rotateActive then 
                    CheckObjRotationInput()
                else
                    CheckObjMovementInput()
                end
                if IsControlJustReleased(0, Keys["F3"]) then
                    rotateActive = not rotateActive
				end
				if IsControlJustReleased(0, Keys["LEFTALT"]) then
					PlaceObjectOnGroundProperly(SelectedObj)
					local groundPos = GetEntityCoords(SelectedObj)
					SelObjPos.z = groundPos.z
                end
				if IsControlJustReleased(0, Keys["ENTER"]) then
					SetNuiFocus(true, true)
					cursorEnabled = not cursorEnabled
					if not isEdit then
						SendNUIMessage({
							type = "buyOption",
						})
					else
						SetNuiFocus(false, false)
						cursorEnabled = not cursorEnabled
						SaveDecorations()
						SelectedObj = nil
						SelObjId = 0
						peanut = false
						isEdit = false
					end
				end
			else
				if IsControlJustPressed(0, Keys["F5"]) then
					if not cursorEnabled then
						SetNuiFocus(true, true)
					end
				end
            end
		end
	end
end)

-- Out of area
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if DecoMode then
			local camPos = GetCamCoord(MainCamera)
			if GetDistanceBetweenCoords(camPos.x, camPos.y, camPos.z, Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, false) > 50.0 then
				DisableEditMode()
				closeDecorateUI()
				--exports["mythic_notify"]:DoHudText('inform', 'Te has quedado fuera del alcance')
			end
		end
	end
end)


RegisterNetEvent("hhrp-housing:client:decorate")
AddEventHandler("hhrp-housing:client:decorate", function()
	Citizen.Wait(500)
	if inside then 
		if hasKey then 
			if not DecoMode then
				EnableEditMode()
				openDecorateUI()
			end
		else
			--exports["mythic_notify"]:DoHudText('error', 'No tienes las llaves de esta casa')
		end
	else
		--exports["mythic_notify"]:DoHudText('error', 'No estás dentro de ningúna casa')
	end
end)

function openDecorateUI()
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = "openObjects",
		furniture = Config.Furniture,
	})
	SetCursorLocation(0.5, 0.5)
end

function closeDecorateUI()
	cursorEnabled = not cursorEnabled
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "closeUI",
	})
end

RegisterNetEvent("hhrp-housing:server:sethousedecorations")
AddEventHandler("hhrp-housing:server:sethousedecorations", function(house, decorations)
	Config.Houses[house].decorations = decorations
	if inside and closesthouse == house then 
		LoadDecorations(house)
	end
end)

RegisterNUICallback("closedecorations", function(data, cb)
	if previewObj ~= nil then 
		DeleteObject(previewObj)
	end
	DisableEditMode()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("deleteSelectedObject", function(data, cb)
	DeleteObject(SelectedObj)
	SelectedObj = nil
	table.remove(ObjectList, SelObjId)
	Citizen.Wait(100)
	SaveDecorations()
	SelObjId = 0
	peanut = false
end)

RegisterNUICallback("cancelSelectedObject", function(data, cb)
	DeleteObject(SelectedObj)
	SelectedObj = nil
	SelObjId = 0
	peanut = false
end)

RegisterNUICallback("buySelectedObject", function(data, cb)
	SetNuiFocus(false, false)
	cursorEnabled = not cursorEnabled
	SaveDecorations()
	SelectedObj = nil
	SelObjId = 0
	peanut = false
end)

RegisterNUICallback('setupMyObjects', function(data, cb)
	local Objects = {}
	for k, v in pairs(ObjectList) do
		if ObjectList[k] ~= nil then
			table.insert(Objects, {
				rotx = v.rotx,
				object = v.object,
				y = v.y,
				hashname = v.hashname,
				x = v.x,
				rotz = v.rotz,
				objectId = v.objectId,
				roty = v.roty,
				z = v.z,
			})
		end
	end
	Wait(100)

	cb(Objects)
end)

RegisterNUICallback('removeObject', function()
	if previewObj ~= nil then 
		DeleteObject(previewObj)
	end
end)

RegisterNUICallback('toggleCursor', function()
	if cursorEnabled then
		SetNuiFocus(false, false)
	end

	cursorEnabled = not cursorEnabled
end)

RegisterNUICallback('selectOwnedObject', function(data)
	local objectData = data.objectData

	local ownedObject = GetClosestObjectOfType(objectData.x, objectData.y, objectData.z, 1.5, GetHashKey(objectData.hashname), false, 6, 7)
	local pos = GetEntityCoords(ownedObject, true)
    local rot = GetEntityRotation(ownedObject)
    SelObjRot = {x = rot.x, y = rot.y, z = rot.z}
	SelObjPos = {x = pos.x, y = pos.y, z = pos.z}
	SelObjHash = objectData.hashname
	SelObjId = objectData.objectId
	SelectedObj = ownedObject
	FreezeEntityPosition(SelectedObj, true)
	peanut = true
end)

RegisterNUICallback('editOwnedObject', function(data)
	SetNuiFocus(false, false)
	cursorEnabled = not cursorEnabled
	local objectData = data.objectData

	local ownedObject = GetClosestObjectOfType(objectData.x, objectData.y, objectData.z, 1.5, GetHashKey(objectData.hashname), false, 6, 7)
	local pos = GetEntityCoords(ownedObject, true)
	local rot = GetEntityRotation(ownedObject)
    SelObjRot = {x = rot.x, y = rot.y, z = rot.z}
	SelObjPos = {x = pos.x, y = pos.y, z = pos.z}
	SelObjHash = objectData.hashname
	SelObjId = objectData.objectId
	SelectedObj = ownedObject
	isEdit = true
	FreezeEntityPosition(SelectedObj, true)
	peanut = true
end)

RegisterNUICallback('deselectOwnedObject', function()
	SelectedObj = nil
	peanut = false
end)

RegisterNUICallback("spawnobject", function(data, cb)
	SetNuiFocus(false, false)
	cursorEnabled = not cursorEnabled
	if previewObj ~= nil then 
		DeleteObject(previewObj)
	end
	local modelHash = GetHashKey(tostring(data.object))
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
	    Citizen.Wait(1000)
	end
	local rotation = GetCamRot(MainCamera, 2)
	local xVect = 2.5 * math.sin( degToRad( rotation.z ) ) * -1.0
	local yVect = 2.5 * math.cos( degToRad( rotation.z ) )
	
    SelectedObj = CreateObject(modelHash, curPos.x + xVect, curPos.y + yVect, curPos.z, false, false, false)
    local pos = GetEntityCoords(SelectedObj, true)
    local rot = GetEntityRotation(SelectedObj)
    SelObjRot = {x = rot.x, y = rot.y, z = rot.z}
	SelObjPos = {x = pos.x, y = pos.y, z = pos.z}
	SelObjHash = data.object
    PlaceObjectOnGroundProperly(SelectedObj)
    peanut = true
end)

RegisterNUICallback("chooseobject", function(data, cb)
	if previewObj ~= nil then 
		DeleteObject(previewObj)
	end
    local modelHash = GetHashKey(tostring(data.object))
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
	    Citizen.Wait(1000)
	end
	local rotation = GetCamRot(MainCamera, 2)
	local xVect = 2.5 * math.sin( degToRad( rotation.z ) ) * -1.0
    local yVect = 2.5 * math.cos( degToRad( rotation.z ) )
    previewObj = CreateObject(modelHash, curPos.x + xVect, curPos.y + yVect, curPos.z, false, false, false)
    PlaceObjectOnGroundProperly(previewObj)
end)

function EnableEditMode()
	local pos = GetEntityCoords(GetPlayerPed(-1), true)
	curPos = {x = pos.x, y = pos.y, z = pos.z}
	SetEntityVisible(GetPlayerPed(-1), false)
	CreateEditCamera()
	DecoMode = true
end

function DisableEditMode()
	SetNuiFocus(false, false)
	SaveDecorations()
	SetEntityVisible(GetPlayerPed(-1), true)
	SetDefaultCamera()
	EnableAllControlActions(0)
	ObjectList = nil
	SelectedObj = nil
	peanut = false
	DecoMode = false
end

function UnloadDecorations()
	if ObjectList ~= nil then 
		for k, v in pairs(ObjectList) do
			if DoesEntityExist(v.object) then
				DeleteObject(v.object)
			end
		end
	end
end

function LoadDecorations(house)
	if Config.Houses[house].decorations == nil or next(Config.Houses[house].decorations) == nil then
		HHCore.TriggerServerCallback('hhrp-housing:server:getHouseDecorations', function(result)
			Config.Houses[house].decorations = result
			if Config.Houses[house].decorations ~= nil then
				ObjectList = {}
				for k, v in pairs(Config.Houses[house].decorations) do
					if Config.Houses[house].decorations[k] ~= nil then 
						if Config.Houses[house].decorations[k].object ~= nil then
							if DoesEntityExist(Config.Houses[house].decorations[k].object) then
								DeleteObject(Config.Houses[house].decorations[k].object)
							end
						end
						local modelHash = GetHashKey(Config.Houses[house].decorations[k].hashname)
						RequestModel(modelHash)
						while not HasModelLoaded(modelHash) do
							Citizen.Wait(10)
						end
						local decorateObject = CreateObject(modelHash, Config.Houses[house].decorations[k].x, Config.Houses[house].decorations[k].y, Config.Houses[house].decorations[k].z, false, false, false)
						SetEntityRotation(decorateObject, Config.Houses[house].decorations[k].rotx, Config.Houses[house].decorations[k].roty, Config.Houses[house].decorations[k].rotz)
						ObjectList[Config.Houses[house].decorations[k].objectId] = {hashname = Config.Houses[house].decorations[k].hashname, x = Config.Houses[house].decorations[k].x, y = Config.Houses[house].decorations[k].y, z = Config.Houses[house].decorations[k].z, rotx = Config.Houses[house].decorations[k].rotx, roty = Config.Houses[house].decorations[k].roty, rotz = Config.Houses[house].decorations[k].rotz, object = decorateObject, objectId = Config.Houses[house].decorations[k].objectId}
						FreezeEntityPosition(decorateObject, true)
					end
				end
			end
		end, house)
	elseif Config.Houses[house].decorations ~= nil then
		ObjectList = {}
		for k, v in pairs(Config.Houses[house].decorations) do
			if Config.Houses[house].decorations[k] ~= nil then 
				if Config.Houses[house].decorations[k].object ~= nil then
					if DoesEntityExist(Config.Houses[house].decorations[k].object) then
						DeleteObject(Config.Houses[house].decorations[k].object)
					end
				end
				local modelHash = GetHashKey(Config.Houses[house].decorations[k].hashname)
				RequestModel(modelHash)
				while not HasModelLoaded(modelHash) do
					Citizen.Wait(10)
				end
				local decorateObject = CreateObject(modelHash, Config.Houses[house].decorations[k].x, Config.Houses[house].decorations[k].y, Config.Houses[house].decorations[k].z, false, false, false)
				Config.Houses[house].decorations[k].object = decorateObject
				SetEntityRotation(decorateObject, Config.Houses[house].decorations[k].rotx, Config.Houses[house].decorations[k].roty, Config.Houses[house].decorations[k].rotz)
				ObjectList[Config.Houses[house].decorations[k].objectId] = {hashname = Config.Houses[house].decorations[k].hashname, x = Config.Houses[house].decorations[k].x, y = Config.Houses[house].decorations[k].y, z = Config.Houses[house].decorations[k].z, rotx = Config.Houses[house].decorations[k].rotx, roty = Config.Houses[house].decorations[k].roty, rotz = Config.Houses[house].decorations[k].rotz, object = decorateObject, objectId = Config.Houses[house].decorations[k].objectId}
				FreezeEntityPosition(decorateObject, true)
			end
		end
	end
end

function SaveDecorations()
	if closesthouse ~= nil then
		if SelectedObj ~= nil then
			if SelObjId ~= 0 then
				ObjectList[SelObjId] = {hashname = SelObjHash, x = SelObjPos.x, y = SelObjPos.y, z = SelObjPos.z, rotx = SelObjRot.x, roty = SelObjRot.y, rotz = SelObjRot.z, object = SelectedObj, objectId = SelObjId}
			else
				if ObjectList ~= nil then
					ObjectList[#ObjectList+1] = {hashname = SelObjHash, x = SelObjPos.x, y = SelObjPos.y, z = SelObjPos.z, rotx = SelObjRot.x, roty = SelObjRot.y, rotz = SelObjRot.z, object = SelectedObj, objectId = #ObjectList+1}
				else
					ObjectList[1] = {hashname = SelObjHash, x = SelObjPos.x, y = SelObjPos.y, z = SelObjPos.z, rotx = SelObjRot.x, roty = SelObjRot.y, rotz = SelObjRot.z, object = SelectedObj, objectId = #ObjectList+1}
				end
			end

			for k, v in pairs(ObjectList) do
				DeleteObject(v.object)
			end
		end
		TriggerServerEvent("hhrp-housing:server:savedecorations", closesthouse, ObjectList)
	end
end

function CheckObjMovementInput()
	local xVect = speeds[curSpeed]
    local yVect = speeds[curSpeed]
    local zVect = speeds[curSpeed]

    if IsControlPressed( 1, Keys["TOP"]) or IsDisabledControlPressed(1, Keys["TOP"]) then
    	SelObjPos.x = SelObjPos.x + xVect
    end

    if IsControlPressed( 1, Keys["DOWN"]) or IsDisabledControlPressed(1, Keys["DOWN"]) then
    	SelObjPos.x = SelObjPos.x - xVect
    end

    if IsControlPressed( 1, Keys["LEFT"]) or IsDisabledControlPressed(1, Keys["LEFT"]) then
    	SelObjPos.y = SelObjPos.y + yVect
    end

    if IsControlPressed( 1, Keys["RIGHT"]) or IsDisabledControlPressed(1, Keys["RIGHT"]) then
    	SelObjPos.y = SelObjPos.y - yVect
    end

    if IsControlPressed( 1, Keys["PAGEUP"]) or IsDisabledControlPressed(1, Keys["PAGEUP"]) then
    	SelObjPos.z = SelObjPos.z + zVect
    end

    if IsControlPressed( 1, Keys["PAGEDOWN"]) or IsDisabledControlPressed(1, Keys["PAGEDOWN"]) then
    	SelObjPos.z = SelObjPos.z - zVect
    end

    SetEntityCoords(SelectedObj, SelObjPos.x, SelObjPos.y, SelObjPos.z)
end

function CheckObjRotationInput()
	local xVect = speeds[curSpeed] * 5.5
    local yVect = speeds[curSpeed] * 5.5
    local zVect = speeds[curSpeed] * 5.5

	if IsControlPressed( 1, Keys["TOP"]) or IsDisabledControlPressed(1, Keys["TOP"]) then
    	SelObjRot.x = SelObjRot.x + xVect
    end

    if IsControlPressed( 1, Keys["DOWN"]) or IsDisabledControlPressed(1, Keys["DOWN"]) then
    	SelObjRot.x = SelObjRot.x - xVect
    end

    if IsControlPressed( 1, Keys["LEFT"]) or IsDisabledControlPressed(1, Keys["LEFT"]) then
    	SelObjRot.z = SelObjRot.z + zVect
    end

    if IsControlPressed( 1, Keys["RIGHT"]) or IsDisabledControlPressed(1, Keys["RIGHT"]) then
    	SelObjRot.z = SelObjRot.z - zVect
    end

    if IsControlPressed( 1, Keys["PAGEUP"]) or IsDisabledControlPressed(1, Keys["PAGEUP"]) then
    	SelObjRot.y = SelObjRot.y + yVect
    end

    if IsControlPressed( 1, Keys["PAGEDOWN"]) or IsDisabledControlPressed(1, Keys["PAGEDOWN"]) then
    	SelObjRot.y = SelObjRot.y - yVect
    end

	SetEntityRotation(SelectedObj, SelObjRot.x, SelObjRot.y, SelObjRot.z)
end

function CheckRotationInput()
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(MainCamera, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(2.0)*(4.0+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(2.0)*(4.0+0.1)), -20.5)
		SetCamRot(MainCamera, new_x, 0.0, new_z, 2)
	end
end

function CheckMovementInput()
	local rotation = GetCamRot(MainCamera, 2)

	if IsControlJustReleased(0, Keys["LEFTSHIFT"]) then
		curSpeed = curSpeed + 1
		if curSpeed > getTableLength(speeds) then
			curSpeed = 1
		end
		--exports["mythic_notify"]:DoHudText('inform', 'La velocidad es: '.. tostring(speeds[curSpeed]))
		HHCore.ShowNotification('Speed is '.. tostring(speeds[curSpeed]))
	end

	local xVect = speeds[curSpeed] * math.sin( degToRad( rotation.z ) ) * -1.0
    local yVect = speeds[curSpeed] * math.cos( degToRad( rotation.z ) )
    local zVect = speeds[curSpeed] * math.tan( degToRad( rotation.x ) - degToRad( rotation.y ))

    if IsControlPressed( 1, Keys["W"]) or IsDisabledControlPressed(1, Keys["W"]) then
    	curPos.x = curPos.x + xVect
        curPos.y = curPos.y + yVect
        curPos.z = curPos.z + zVect
    end

    if IsControlPressed( 1, Keys["S"]) or IsDisabledControlPressed(1, Keys["S"]) then
    	curPos.x = curPos.x - xVect
        curPos.y = curPos.y - yVect
        curPos.z = curPos.z - zVect
	end

	SetCamCoord(MainCamera, curPos.x, curPos.y, curPos.z)
end

function CreateEditCamera()
	local rot = GetEntityRotation(GetPlayerPed(-1))
	local pos = GetEntityCoords(GetPlayerPed(-1), true)
	MainCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 60.00, false, 0)
	SetCamActive(MainCamera, true)
	RenderScriptCams(true, false, 1, true, true)
end

function SetDefaultCamera()
	RenderScriptCams(false, true, 500, true, true)
	SetCamActive(MainCamera, false)
	DestroyCam(MainCamera, true)
	DestroyAllCams(true)
end

function ShowHelpNotification(msg)
	BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function getTableLength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

function degToRad( degs )
    return degs * 3.141592653589793 / 180
end
