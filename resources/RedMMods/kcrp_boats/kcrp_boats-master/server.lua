local function GetAmmoutBoates( Player_ID, Character_ID )
    local HasBoates = MySQL.Sync.fetchAll( "SELECT * FROM boates WHERE identifier = @identifier AND charid = @charid ", {
        ['identifier'] = Player_ID,
        ['charid'] = Character_ID
    } )
    if #HasBoates > 0 then return true end
    return false
end

RegisterServerEvent('elrp:buyboat')
AddEventHandler( 'elrp:buyboat', function ( args )

    local _src   = source
    local _price = args['Price']
    local _level = args['Level']
    local _model = args['Model']

	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
        u_identifier = user.getIdentifier()
        u_level = user.getLevel()
        u_charid = user.getSessionVar("charid")
        u_money = user.getMoney()
    end)

    local _resul = GetAmmoutBoates( u_identifier, u_charid )

    if u_money <= _price then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.NoMoney )
        return
    end

    if u_level <= _level then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.LevelMissing )
        return
    end

	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
        user.removeMoney(_price)
    end)

		
    if _resul ~= true then
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['boat'] = _model }
        MySQL.Async.execute("INSERT INTO boates ( `identifier`, `charid`, `boat` ) VALUES ( @identifier, @charid, @boat )", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You Rented a new Boat !' )
    else
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['boat'] = _model }
        MySQL.Async.execute(" UPDATE boates SET boat = @boat WHERE identifier = @identifier AND charid = @charid ", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, '' )
    end

end)

RegisterServerEvent( 'elrp:dropboat' )
AddEventHandler( 'elrp:dropboat', function ( )

    local _src = source

	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
	    u_identifier = user.getIdentifier()
	    u_charid = user.getSessionVar("charid")
	end)

    local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid }
    local HasBoates = MySQL.Sync.fetchAll( "SELECT * FROM Boates WHERE identifier = @identifier AND charid = @charid ", Parameters )

    if HasBoates[1] then
        local boat = HasBoates[1].boat
        TriggerClientEvent("elrp:spawnBoat", _src, boat)
    end

end )
