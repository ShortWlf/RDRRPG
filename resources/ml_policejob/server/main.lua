RegisterServerEvent("ml_policejob:checkjob")
AddEventHandler("ml_policejob:checkjob", function()
      local _src = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
print(user.getJob())
        if user.getJob() == 'police' then
            TriggerClientEvent('ml_policejob:open', _src)
        else
            print('not authorized')
        end
    end)
end)

RegisterServerEvent("ml_policejob:checkjob2")
AddEventHandler("ml_policejob:checkjob2", function()
      local _src = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
print(user.getJob())
        if user.getJob() == 'police' then
            TriggerClientEvent('ml_policejob:open2', _src)
        else
            print('not authorized')
        end
    end)
end)

--cuff

RegisterServerEvent('ml_policejob:cuffplayer')
AddEventHandler('ml_policejob:cuffplayer', function(target)
TriggerEvent('redemrp:getPlayerFromId', target, function()
        TriggerClientEvent('ml_policejob:cuff', target)
        print('servercuff')
    end)
end)

RegisterServerEvent('ml_policejob:uncuffplayer')
AddEventHandler('ml_policejob:uncuffplayer', function(target)
TriggerEvent('redemrp:getPlayerFromId', target, function()
        TriggerClientEvent('ml_policejob:uncuff', target)
        print('serveruncuff')
    end)
end)

--lasso


RegisterServerEvent('ml_policejob:lassoplayer')
AddEventHandler('ml_policejob:lassoplayer', function(target)
TriggerEvent('redemrp:getPlayerFromId', target, function()
        --TriggerClientEvent('ml_policejob:lasso', target)
		TriggerClientEvent('ml_policejob:hogtie', target)
        print('serverlasso')
    end)
end)



