ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('mrw_prop:Save')
AddEventHandler('mrw_prop:Save', function(name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, garage, price)

    local x_source = source

	MySQL.Async.execute('INSERT INTO properties (name, label ,entering ,`exit`,inside,outside,ipls,is_single,is_room,is_gateway,room_menu,garage,price) VALUES (@name,@label,@entering,@exit,@inside,@outside,@ipl,@isSingle,@isRoom,@isGateway,@roommenu,@garage,@price)',
		{
			['@name'] = name,
			['@label'] = label,
			['@entering'] = entering,
			['@exit'] = exit,
			['@inside'] = inside,
			['@outside'] = outside,
			['@ipl'] = ipl,
			['@isSingle'] = isSingle,
			['@isRoom'] = isRoom,
			['@isGateway'] = isGateway,
			['@roommenu'] = roommenu,
			['@garage'] = garage,
			['@price'] = price,

		}, 
		function (rowsChanged)
			TriggerClientEvent('esx:showNotification', x_source, 'Propriété bien enregistré')
		end
	)
end)

