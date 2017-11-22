local PlayersWashing = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function WashMoney(source,percent)
	local _source=source
	SetTimeout(10000, function()

		if PlayersWashing[source] == true then
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local blackMoney=xPlayer.getAccount('black_money')
			local _percent
				if blackMoney.money < Config.Slice then
					TriggerClientEvent('esx_moneywash:showNotification', source, 'You do not have enough money to launder, minimum : $' .. Config.Slice)
				else
					
					bonus=math.random(0,10)
					local washedMoney = math.floor(Config.Slice / 100 * (_percent + bonus))
					
					xPlayer.removeAccountMoney('black_money', Config.Slice)
					xPlayer.addMoney(washedMoney)

					WashMoney(source,_percent)
				end

			
		end
	end)
end

RegisterServerEvent('esx_moneywash:startWash')
AddEventHandler('esx_moneywash:startWash', function(percent)
	PlayersWashing[source] = true
	TriggerClientEvent('esx_moneywash:showNotification', source, 'Bleaching in progress...')
	WashMoney(source,percent)
end)

RegisterServerEvent('esx_moneywash:pasLa')
AddEventHandler('esx_moneywash:pasLa', function()
	PlayersWashing[source] = false
	TriggerClientEvent('esx_moneywash:showNotification', source, 'Come back later...')
end)


RegisterServerEvent('esx_moneywash:stopWash')
AddEventHandler('esx_moneywash:stopWash', function()
	PlayersWashing[source] = false
end)
