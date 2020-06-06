-- EXMAPLE USAGE:
--
-- FOR LUA ONLY!:
--
-- exports.redem_roleplay.DisplayTip(0, "your text", tonumber(8000))
-- exports.redem_roleplay.DisplayTopCenterNotification(0, "your text", tonumber(8000))
-- exports.redem_roleplay.DisplayLeftNotification(0, "your text", "second text", "generic_textures", "tick", tonumber(8000))
-- OR JUST
-- TriggerClientEvent('redem_roleplay:NotifyLeft', "first text", "second text", "generic_textures", "tick", 8000)
-- TriggerClientEvent('redem_roleplay:Tip', "your text", 8000)
-- TriggerClientEvent('redem_roleplay:NotifyTop', "your text", 8000)

RegisterNetEvent('redem_roleplay:NotifyLeft')
AddEventHandler('redem_roleplay:NotifyLeft', function(firsttext, secondtext, dict, icon, duration)
    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true) 
            while not HasStreamedTextureDictLoaded(dict) do
                Wait(0)
            end
    end
    if icon ~= nil then
        exports.redem_roleplay.DisplayLeftNotification(0, tostring(firsttext), tostring(secondtext), tostring(dict), tostring(icon), tonumber(duration))
    else
        local icon = "tick"
        exports.redem_roleplay.DisplayLeftNotification(0, tostring(firsttext), tostring(secondtext), tostring(dict), tostring(icon), tonumber(duration))
    end
end)

RegisterNetEvent('redem_roleplay:Tip')
AddEventHandler('redem_roleplay:Tip', function(text, duration)
exports.redem_roleplay.DisplayTip(0, tostring(text), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:NotifyTop')
AddEventHandler('redem_roleplay:NotifyTop', function(text, duration)
exports.redem_roleplay.DisplayTopCenterNotification(0, tostring(text), tonumber(duration))
end)
