TriggerEvent("es:addGroup", "mod", "user", function(group) end)

-- Modify if you want, btw the _admin_ needs to be able to target the group and it will work
local groupsRequired = {
    slay = "admin",
    noclip = "admin",
    crash = "superadmin",
    freeze = "mod",
    bring = "mod",
    ["goto"] = "mod",
    slap = "admin",
    slay = "admin",
    kick = "mod",
    ban = "admin"
}

local banned = ""
local bannedTable = {}

function loadBans()
	banned = LoadResourceFile(GetCurrentResourceName(), "bans.json") or ""
	if banned ~= "" then
		bannedTable = json.decode(banned)
	else
		bannedTable = {}
	end
end

RegisterCommand("refresh_bans", function()
	loadBans()
end, true)

function loadExistingPlayers()
	TriggerEvent("redem:getPlayers", function(curPlayers)
		for k,v in pairs(curPlayers)do
			TriggerClientEvent("redem_admin:setGroup", v.get('source'), v.get('group'))
		end
	end)
end

loadExistingPlayers()

function removeBan(id)
	bannedTable[id] = nil
	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

function isBanned(id)
	if bannedTable[id] ~= nil then
		if bannedTable[id].expire < os.time() then
			removeBan(id)
			return false
		else
			return bannedTable[id]
		end
	else
		return false
	end
end

function permBanUser(bannedBy, id)
	bannedTable[id] = {
		banner = bannedBy,
		reason = "Permanently banned from this server",
		expire = os.time() + 365*24*60*60
	}

	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)

	loadBans()
end

function banUser(expireSeconds, bannedBy, id, re)
	bannedTable[id] = {
		banner = bannedBy,
		reason = re,
		expire = (os.time() + expireSeconds)
	}

	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

AddEventHandler('playerConnecting', function(user, set, deferals)
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		local banData = isBanned(v)
		if banData ~= false then
			CancelEvent()
			set("Banned for: " .. banData.reason .. "\nExpires: " .. (os.date("%c", banData.expire)))
		end
	end
end)

AddEventHandler('redem:incorrectAmountOfArguments', function(source, wantedArguments, passedArguments, user, command)
	if(source == 0)then
		print("Argument count mismatch (passed " .. passedArguments .. ", wanted " .. wantedArguments .. ")")
	else
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1SYSTEM", "Incorrect amount of arguments! (" .. passedArguments .. " passed, " .. requiredArguments .. " wanted)"}
		})
	end
end)

RegisterServerEvent('redem_admin:all')
AddEventHandler('redem_admin:all', function(type)
	local Source = source
	TriggerEvent('redem:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "superadmin", function(available)
			if available or user.getGroup() == "superadmin" then
				if type == "slay_all" then TriggerClientEvent('redem_admin:quick', -1, 'slay') end
				if type == "bring_all" then TriggerClientEvent('redem_admin:quick', -1, 'bring', Source) end
				if type == "slap_all" then TriggerClientEvent('redem_admin:quick', -1, 'slap') end
			else
				TriggerClientEvent('chat:addMessage', Source, {
					args = {"^1SYSTEM", "por todos"}
				})
				TriggerClientEvent('chat:addMessage', Source, {
					args = {"^1SYSTEM", "You do not have permission to do this"}
				})
			end
		end)
	end)
end)

RegisterServerEvent('redem_admin:quick')
AddEventHandler('redem_admin:quick', function(id, type)
	local Source = source
	TriggerEvent('redem:getPlayerFromId', source, function(user)
		TriggerEvent('redem:getPlayerFromId', id, function(target)
			TriggerEvent('es:canGroupTarget', user.getGroup(), groupsRequired[type], function(available)
				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget and available then
						if type == "slay" then TriggerClientEvent('redem_admin:quick', id, type) end
						if type == "noclip" then TriggerClientEvent('redem_admin:quick', id, type) end
						if type == "freeze" then TriggerClientEvent('redem_admin:quick', id, type) end
						if type == "crash" then TriggerClientEvent('redem_admin:quick', id, type) end
						if type == "bring" then TriggerClientEvent('redem_admin:quick', id, type, Source) end
						if type == "goto" then TriggerClientEvent('redem_admin:quick', Source, type, id) end
						if type == "slap" then TriggerClientEvent('redem_admin:quick', id, type) end
						if type == "slay" then TriggerClientEvent('redem_admin:quick', id, type) end
						if type == "kick" then DropPlayer(id, 'Kicked by redem_admin GUI') end

						if type == "ban" then
							local ip
							for k,v in ipairs(GetPlayerIdentifiers(source))do
								if string.sub(v, 1, string.len("steam:")) == "steam:" then
									permBanUser(user.identifier, v)
								elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
									permBanUser(user.identifier, v)
								end
							end 
							DropPlayer(id, GetConvar("redem_admin_banreason", "You were banned from this server"))
						end
					else
						if not available then
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "for available"}
							})
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "You do not have permission to do this"}
							})
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "for other"}
							})
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "You do not have permission to do this"}
							})
						end
					end
				end)
			end)
		end)
	end)
end)

AddEventHandler('redem:playerLoaded', function(Source, user)
	TriggerClientEvent('redem_admin:setGroup', Source, user.getGroup())
end)

RegisterServerEvent('redem_admin:set')
AddEventHandler('redem_admin:set', function(t, USER, GROUP)
	local Source = source
	TriggerEvent('redem:getPlayerFromId', source, function(user)
		TriggerEvent('redem:canGroupTarget', user.getGroup(), "admin", function(available)
			if available then
			if t == "group" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', source, {
						args = {"^1SYSTEM", "Player not found"}
					})
				else
					TriggerEvent("redem:getAllGroups", function(groups)
						if(groups[GROUP])then
							TriggerEvent("redem:setPlayerData", USER, "group", GROUP, function(response, success)
								TriggerClientEvent('redem_admin:setGroup', USER, GROUP)
								TriggerClientEvent('chat:addMessage', -1, {
									args = {"^1CONSOLE", "Group of ^2^*" .. GetPlayerName(tonumber(USER)) .. "^r^0 has been set to ^2^*" .. GROUP}
								})
							end)
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^1SYSTEM", "Group not found"}
							})
						end
					end)
				end
				-- level not used ussually, disable money because that is controlled by redemrp
			--[[elseif t == "level" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^1SYSTEM", "Player not found"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent("redem:setPlayerData", USER, "permission_level", GROUP, function(response, success)
							if(true)then
								TriggerClientEvent('chat:addMessage', -1, {
									args = {"^1CONSOLE", "Permission level of ^2" .. GetPlayerName(tonumber(USER)) .. "^0 has been set to ^2 " .. tostring(GROUP)}
								})
							end
						end)

						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1SYSTEM", "Permission level of ^2" .. GetPlayerName(tonumber(USER)) .. "^0 has been set to ^2 " .. tostring(GROUP)}
						})
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1SYSTEM", "Invalid integer entered"}
						})
					end
				end
			elseif t == "money" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^1SYSTEM", "Player not found"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('redem:getPlayerFromId', USER, function(target)
							target.setMoney(GROUP)
						end)
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1SYSTEM", "Invalid integer entered"}
						})
					end
				end
			elseif t == "bank" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^1SYSTEM", "Player not found"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('redem:getPlayerFromId', USER, function(target)
							target.setBankBalance(GROUP)
						end)
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^1SYSTEM", "Invalid integer entered"}
						})
					end
				end--]]
			end
			else
				TriggerClientEvent('chat:addMessage', Source, {
					args = {"^1SYSTEM", "Superadmin required to do this"}
				})
			end
		end)
	end)
end)

RegisterCommand('setadmin', function(source, args, raw)
	local player = tonumber(args[1])
	local level = tonumber(args[2])
	if args[1] then
		if (player and GetPlayerName(player)) then
			if level then
				TriggerEvent("redem:setPlayerData", tonumber(args[1]), "permission_level", tonumber(args[2]), function(response, success)
					RconPrint(response)
		
					TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'rank', tonumber(args[2]), true)
					TriggerClientEvent('chat:addMessage', -1, {
						args = {"^1CONSOLE", "Permission level of ^2" .. GetPlayerName(tonumber(args[1])) .. "^0 has been set to ^2 " .. args[2]}
					})
				end)
			else
				RconPrint("Invalid integer\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: setadmin [user-id] [permission-level]\n")
	end
end, true)

RegisterCommand('setgroup', function(source, args, raw)
	local player = tonumber(args[1])
	local group = args[2]
	if args[1] then
		if (player and GetPlayerName(player)) then
			TriggerEvent("redem:getAllGroups", function(groups)

				if(groups[args[2]])then
					TriggerEvent("redem:getPlayerFromId", player, function(user)
						ExecuteCommand('remove_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())

						TriggerEvent("redem:setPlayerData", player, "group", args[2], function(response, success)
							TriggerClientEvent('redem:setPlayerDecorator', player, 'group', tonumber(group), true)
							TriggerClientEvent('chat:addMessage', -1, {
								args = {"^1CONSOLE", "Group of ^2^*" .. GetPlayerName(player) .. "^r^0 has been set to ^2^*" .. group}
							})

							ExecuteCommand('add_principal identifier.' .. user.getIdentifier() .. " group." .. user.getGroup())
						end)
					end)
				else
					RconPrint("This group does not exist.\n")
				end
			end)
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: setgroup [user-id] [group]\n")
	end
end, true)

RegisterCommand('giverole', function(source, args, raw)
	local player = tonumber(args[1])
	local role = table.concat(args, " ", 2)
	if args[1] then
		if (player and GetPlayerName(player)) then
			if args[2] then
				TriggerEvent("redem:getPlayerFromId", player, function(user)
					user.giveRole(role)
					TriggerClientEvent('chat:addMessage', user.get('source'), {
						args = {"^1SYSTEM", "You've been given a role: ^2" .. role}
					})
				end)
			else
				RconPrint("Usage: giverole [user-id] [role]\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: giverole [user-id] [role]\n")
	end
end, true)

RegisterCommand('removerole', function(source, args, raw)
	local player = tonumber(args[1])
	local role = table.concat(args, " ", 2)
	if args[1] then
		if (player and GetPlayerName(player)) then
			if args[2] then
				TriggerEvent("redem:getPlayerFromId", tonumber(args[1]), function(user)
					user.removeRole(role)
					TriggerClientEvent('chat:addMessage', user.get('source'), {
						args = {"^1SYSTEM", "You've been removed a role: ^2" .. role}
					})
				end)
			else
				RconPrint("Usage: removerole [user-id] [role]\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: removerole [user-id] [role]\n")
	end
end, true)

RegisterCommand('setmoney', function(source, args, raw)
	local player = tonumber(args[1])
	local money = tonumber(args[2])
	if args[1] then
		if (player and GetPlayerName(player)) then
			if money then
				TriggerEvent("redem:getPlayerFromId", player, function(user)
					if(user)then
						user.setMoney(money)

						RconPrint("Money set")
						TriggerClientEvent('chat:addMessage', player, {
							args = {"^1SYSTEM", "Your money has been set to: ^2^*$" .. money}
						})
					end
				end)
			else
				RconPrint("Invalid integer\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: setmoney [user-id] [money]\n")
	end
end, true)

-- Default commands
TriggerEvent('redem:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Level: ^*^2 " .. tostring(user.get('permission_level'))}
	})
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Group: ^*^2 " .. user.getGroup()}
	})
end, {help = "Shows what admin level you are and what group you're in"})

-- Ban a person
TriggerEvent("redem:addGroupCommand", 'ban', "admin", function(source, args, user)
	local Source = source
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("redem:getPlayerFromId", player, function(target)
				TriggerEvent('redem:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget then
						local reason = args
						table.remove(reason, 1)
						local time = args[1]
						table.remove(reason, 1)
						if(#reason == 0)then
							reason = "You have been banned from the server"
						else
							reason = "" .. table.concat(reason, " ")
						end

						-- Awful shit logic but eh, it works?
						-- Days
						if string.find(time, "m")then
							time = math.floor(time:gsub("%m", "") * 60)
						elseif string.find(time, "h") then
							time = math.floor(time:gsub("%h", "") * 60 * 60)
						elseif string.find(time, "d") then
							time = math.floor(time:gsub("%d", "") * 60 * 60 * 24)
						elseif string.find(time, "y") then
							time = math.floor(time:gsub("%y", "") * 60 * 60 * 24 * 365)
						end

						TriggerClientEvent('chat:addMessage', -1, {
							args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)"}
						})
						banUser(time, user.getIdentifier(), target.getIdentifier(), reason)
						DropPlayer(player, "Banned for: " .. reason .. "\nExpires: " .. (os.date("%c", os.time() + time)))
					else
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "You can not target this person"}})
					end
				end)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end)

-- Report to admins
TriggerEvent('redem:addCommand', 'report', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1REPORT", " (^2" .. GetPlayerName(source) .. " | " .. source .. "^0) " .. table.concat(args, " ")}
	})

	TriggerEvent("redem:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("redem:getPlayerFromId", k, function(user)
				if(user.getPermissions() > 0 and k ~= source)then
					TriggerClientEvent('chat:addMessage', k, {
						args = {"^1REPORT", " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " ")}
					})
				end
			end)
		end
	end)
end, {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}})

-- Noclip
TriggerEvent('redem:addGroupCommand', 'noclip', "admin", function(source, args, user)
	TriggerClientEvent("redem_admin:noclip", source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Enable or disable noclip"})

-- Kicking
TriggerEvent('redem:addGroupCommand', 'kick', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("redem:getPlayerFromId", player, function(target)

				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kicked: You have been kicked from the server"
				else
					reason = "Kicked: " .. table.concat(reason, " ")
				end

				TriggerClientEvent('chat:addMessage', -1, {
					args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)"}
				})
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"}}})

-- Announcing
TriggerEvent('redem:addGroupCommand', 'announce', "admin", function(source, args, user)
	TriggerClientEvent('chat:addMessage', -1, {
		args = {"^1ANNOUNCEMENT", table.concat(args, " ")}
	})
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})

-- Freezing
local frozen = {}
TriggerEvent('redem:addGroupCommand', 'freeze', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("redem:getPlayerFromId", player, function(target)

				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end

				TriggerClientEvent('redem_admin:freezePlayer', player, frozen[player])

				local state = "unfrozen"
				if(frozen[player])then
					state = "frozen"
				end

				TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been " .. state .. " by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been " .. state} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Bring
TriggerEvent('redem:addGroupCommand', 'bring', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("redem:getPlayerFromId", player, function(target)

				TriggerClientEvent('redem_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z)

				TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have brought by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been brought"} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Teleport a user to you", params = {{name = "userid", help = "The ID of the player"}}})

-- Slap
TriggerEvent('redem:addGroupCommand', 'slap', "admin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("redem:getPlayerFromId", player, function(target)

				TriggerClientEvent('redem_admin:slap', player)

				TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have slapped by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been slapped"} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Slap a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Goto
TriggerEvent('redem:addGroupCommand', 'goto', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("redem:getPlayerFromId", player, function(target)
				if(target)then

					TriggerClientEvent('redem_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z)

					TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been teleported to by ^2" .. GetPlayerName(source)} })
					TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Teleported to player ^2" .. GetPlayerName(player) .. ""} })
				end
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Kill yourself
TriggerEvent('redem:addCommand', 'die', function(source, args, user)
	TriggerClientEvent('redem_admin:kill', source)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "You killed yourself"} })
end, {help = "Suicide"})

-- Slay a player
TriggerEvent('redem:addGroupCommand', 'slay', "admin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("redem:getPlayerFromId", player, function(target)

				TriggerClientEvent('redem_admin:kill', player)

				TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been killed by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been killed."} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Slay a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Crashing
TriggerEvent('redem:addGroupCommand', 'crash', "superadmin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("redem:getPlayerFromId", player, function(target)

				TriggerClientEvent('redem_admin:crash', player)

				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been crashed."} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Crash a user, no idea why this still exists", params = {{name = "userid", help = "The ID of the player"}}})

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

loadBans()
