HHCore = nil

Citizen.CreateThread(function()

	while HHCore == nil do
		TriggerEvent('hhrp:getSharedObject', function(obj) HHCore = obj end)
		Citizen.Wait(0)
	end

	local MenuType    = 'list'
	local OpenedMenus = {}

	local openMenu = function(namespace, name, data)

		OpenedMenus[namespace .. '_' .. name] = true

		SendNUIMessage({
			action    = 'openMenu',
			namespace = namespace,
			name      = name,
			data      = data,
		})

		HHCore.SetTimeout(200, function()
			SetNuiFocus(true, true)
		end)

	end

	local closeMenu = function(namespace, name)

		OpenedMenus[namespace .. '_' .. name] = nil
		local OpenedMenuCount = 0

		SendNUIMessage({
			action    = 'closeMenu',
			namespace = namespace,
			name      = name,
			data      = data,
		})

		for k,v in pairs(OpenedMenus) do
			if v == true then
				OpenedMenuCount = OpenedMenuCount + 1
			end
		end

		if OpenedMenuCount == 0 then
			SetNuiFocus(false)
		end

	end

	HHCore.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)

	RegisterNUICallback('menu_submit', function(data, cb)
		local menu = HHCore.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		if menu.submit ~= nil then
			menu.submit(data, menu)
		end

		cb('OK')
	end)

	RegisterNUICallback('menu_cancel', function(data, cb)
		local menu = HHCore.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		if menu.cancel ~= nil then
			menu.cancel(data, menu)
		end

		cb('OK')
	end)

end)