HHCore = nil

TriggerEvent('hhrp:getSharedObject', function(obj) HHCore = obj end)
hhrp = hhrp or {}
hhrp.Admin = hhrp.Admin or {}
hhrp._Admin = hhrp._Admin or {}
hhrp._Admin.Players = {}
hhrp._Admin.DiscPlayers = {}

RegisterServerEvent('admin:setGroup')
AddEventHandler('admin:setGroup', function(target, rank)
    local source = source
    TriggerEvent("es:setPlayerData", target.src, "group", rank, function(response, success)
        TriggerClientEvent('es_admin:setGroup', target.src, rank)
        TriggerClientEvent('DoLongHudText', source, "Set " .. target.src .. "'s rank to " .. rank .. "!")
    end)
end)

RegisterServerEvent('hhrp-admin:Cloak')
AddEventHandler('hhrp-admin:Cloak', function(src, toggle)
    TriggerClientEvent("hhrp-admin:Cloak", -1, src, toggle)
end)

RegisterServerEvent('admin:addChatMessage')
AddEventHandler('admin:addChatMessage', function(message)
    TriggerClientEvent('chatMessagess', -1, 'Admin: ', 3, message)
end)

RegisterServerEvent('admin:addChatAnnounce')
AddEventHandler('admin:addChatAnnounce', function(message)
    TriggerClientEvent('chatMessagess', -1, 'Announcement: ', 4, message)
end)

RegisterServerEvent('hhrp-admin:RaveMode')
AddEventHandler('hhrp-admin:RaveMode', function(toggle)
    local source = source
    TriggerClientEvent('hhrp-admin:toggleRave', -1, toggle)
end)

RegisterServerEvent('hhrp-admin:AddPlayer')
AddEventHandler("hhrp-admin:AddPlayer", function()
    local licenses
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            licenses = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local licenseid = licenses:gsub("license:", "")
    local ping = GetPlayerPing(source)
    local data = { src = source, steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping}

    TriggerClientEvent("hhrp-admin:AddPlayer", -1, data )
    hhrp.Admin.AddAllPlayers()
end)

RegisterServerEvent('admin:bringPlayer')
AddEventHandler('admin:bringPlayer', function(target)
    local source = source
    local coords = GetEntityCoords(GetPlayerPed(source))
    TriggerClientEvent('hhrp-admin:teleportUser', target, coords.x, coords.y, coords.z)
    TriggerClientEvent('DoLongHudText', source, 'You brought this player.')
end)

function hhrp.Admin.AddAllPlayers(self)
    local xPlayers   = HHCore.GetPlayers()

    for i=1, #xPlayers, 1 do
        
        local licenses
        local identifiers, steamIdentifier = GetPlayerIdentifiers(xPlayers[i])
        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end
        for _, v in pairs(identifiers) do
            if string.find(v, "license") then
                licenses = v
                break
            end
        end
        local ip = GetPlayerEndpoint(xPlayers[i])
        local licenseid = licenses:gsub("license:", "")
        local ping = GetPlayerPing(xPlayers[i])
        local stid = HexIdToSteamId(steamIdentifier)
        local ply = GetPlayerName(xPlayers[i])
        local scomid = steamIdentifier:gsub("steam:", "")
        local data = { src = xPlayers[i], steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping }

        TriggerClientEvent("hhrp-admin:AddAllPlayers", source, data)

    end
end

function hhrp.Admin.AddPlayerS(self, data)
    hhrp._Admin.Players[data.src] = data
end

AddEventHandler("playerDropped", function()
	local licenses
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            licenses = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local licenseid = licenses:gsub("license:", "")
    local ping = GetPlayerPing(source)
    local data = { src = source, steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping}

    TriggerClientEvent("hhrp-admin:RemovePlayer", -1, data )
    Wait(600000)
    TriggerClientEvent("hhrp-admin:RemoveRecent", -1, data)
end)

RegisterCommand('giveitem',function(source,args)
if source == 0 or source=="console" then
    if args[1] ~= nil then
        TriggerClientEvent('player:receiveItem', args[1], args[2], args[3])
    else
        TriggerClientEvent("DoLongHudText", source, 'Invalid Input.',2)
    end
else
    TriggerClientEvent("DoLongHudText", source, 'You Are Not An Admin.',2)
end
end)

--[[ function ST.Scoreboard.RemovePlayerS(self, data)
    ST._Scoreboard.RecentS = data
end

function ST.Scoreboard.RemoveRecentS(self, src)
    ST._Scoreboard.RecentS.src = nil
end ]]

function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end