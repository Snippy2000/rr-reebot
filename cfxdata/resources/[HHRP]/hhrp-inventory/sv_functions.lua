HHCore = nil
local balances = {}

TriggerEvent('hhrp:getSharedObject', function(obj)
    HHCore = obj
end)

RegisterServerEvent('server-inventory-request-identifier')
AddEventHandler('server-inventory-request-identifier', function()
    local src = source
    local xPlayer = HHCore.GetPlayerFromId(src)
    local steam = xPlayer.identifier
    TriggerClientEvent('inventory-client-identifier', src, steam)
end)

RegisterServerEvent("hhrpLockers:sendCaseFileID")
AddEventHandler("hhrpLockers:sendCaseFileID", function(id)
local src = source
TriggerClientEvent("evLockers:openCaseFile", src, id)
end)


RegisterServerEvent('people-search')
AddEventHandler('people-search', function(target)
    local source = source
    local xPlayer = HHCore.GetPlayerFromId(target)
    local identifier = xPlayer.identifier
	TriggerClientEvent("server-inventory-open", source, "1", identifier)

end)

RegisterServerEvent("server-item-quality-update")
AddEventHandler("server-item-quality-update", function(player, data)
	local quality = data.quality
	local slot = data.slot
	local itemid = data.item_id

    exports.ghmattimysql:execute("UPDATE user_inventory2 SET `quality` = @quality WHERE name = @name AND slot = @slot AND item_id = @item_id", {['quality'] = quality, ['name'] = player, ['slot'] = slot, ['item_id'] = itemid})
  
end)

RegisterServerEvent('police:SeizeCash')
AddEventHandler('police:SeizeCash', function(target)
    local src = source
    local xPlayer = HHCore.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local zPlayer = HHCore.GetPlayerFromId(target)

    if not xPlayer.job.name == 'police' then
        print('steam:'..identifier..' User attempted sieze cash')
        return
    end
    TriggerClientEvent("banking:addBalance", src, zPlayer.getMoney())
    TriggerClientEvent("banking:removeBalance", target, zPlayer.getMoney())
    zPlayer.setMoney(0)
end)

RegisterServerEvent('Stealtheybread')
AddEventHandler('Stealtheybread', function(target)
    local src = source
    local xPlayer = HHCore.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local zPlayer = HHCore.GetPlayerFromId(target)

    if not xPlayer.job.name == 'police' then
        print('steam:'..identifier..' User attempted sieze cash')
        return
    end
    TriggerClientEvent("banking:addBalance", src, zPlayer.getMoney())
    TriggerClientEvent("banking:removeBalance", target, zPlayer.getMoney())
    xPlayer.addMoney(zPlayer.getMoney())
    zPlayer.setMoney(0)
end)

RegisterServerEvent("police:showID")
AddEventHandler("police:showID", function(pid,data)
    local src = source
    local xPlayer = HHCore.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local info = json.decode(data)
    local info = {
        status = 1,
        Name = info.Firstname,
        Surname = info.Lastname,
        DOB = info.DOB,
        sex = info.Sex,
        identifier = info.cid
    }
    TriggerClientEvent('chat:showCID', pid, info)
end)

----------------------------------------------------- AMMOOOOOOO ----------------------------------------------------------------


RegisterServerEvent('hhrp-inventory:updateAmmoCount')
AddEventHandler('hhrp-inventory:updateAmmoCount', function(hash, count)
    local player = HHCore.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE hhrp_ammo SET count = @count WHERE hash = @hash AND owner = @owner', {
        ['@owner'] = player.identifier,
        ['@hash'] = hash,
        ['@count'] = count
    }, function(results)
        if results == 0 then
            MySQL.Async.execute('INSERT INTO hhrp_ammo (owner, hash, count) VALUES (@owner, @hash, @count)', {
                ['@owner'] = player.identifier,
                ['@hash'] = hash,
                ['@count'] = count
            })
        end
    end)
end)

HHCore.RegisterServerCallback('hhrp-inventory:getAmmoCount', function(source, cb, hash)
    local player = HHCore.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM hhrp_ammo WHERE owner = @owner and hash = @hash', {
        ['@owner'] = player.identifier,
        ['@hash'] = hash
    }, function(results)
        if #results == 0 then
            cb(nil)
        else
            cb(results[1].count)
        end
    end)
end)