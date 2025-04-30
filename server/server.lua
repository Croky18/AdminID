local QBCore = GetResourceState('qb-core') ~= 'missing' and exports['qb-core']:GetCoreObject() or nil
local ESX = GetResourceState('es_extended') ~= 'missing' and exports['es_extended']:getSharedObject() or nil

RegisterCommand('checkroles', function(source)
    local xPlayer = GetPlayerFrameworkPlayer(source)
    local discordId = GetDiscordIdentifier(source)

    if not discordId then
        Notify(source, "Discord ID niet gevonden.", "error")
        return
    end

    GetPlayerRoles(discordId, function(roles)
        if roles then
            local highestRole = GetHighestRole(roles)
            TriggerClientEvent('discordroles:client:showRoleForAll', -1, source, highestRole)
            Notify(source, "Je rol is: "..highestRole, "success")
        else
            Notify(source, "Kon rollen niet ophalen.", "error")
        end
    end)
end)

RegisterCommand('adminID', function(source)
    local xPlayer = GetPlayerFrameworkPlayer(source)
    local discordId = GetDiscordIdentifier(source)

    if not discordId then return end

    GetPlayerRoles(discordId, function(roles)
        if not Config.OnlyAdminsCheckAllRoles or (roles and roles[Config.AdminRoleId]) then
            local highestRole = GetHighestRole(roles)
            TriggerClientEvent('discordroles:client:showRoleForAll', -1, source, highestRole)
        end
    end)
end)

function Notify(src, msg, type)
    if QBCore then
        TriggerClientEvent('QBCore:Notify', src, msg, type)
    elseif ESX then
        TriggerClientEvent('esx:showNotification', src, msg)
    end
end

function GetPlayerFrameworkPlayer(src)
    if QBCore then
        return QBCore.Functions.GetPlayer(src)
    elseif ESX then
        return ESX.GetPlayerFromId(src)
    end
end

function GetDiscordIdentifier(source)
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            return string.sub(v, 9)
        end
    end
    return nil
end

function GetPlayerRoles(discordId, cb)
    local endpoint = ("https://discord.com/api/guilds/%s/members/%s"):format(Config.GuildId, discordId)
    PerformHttpRequest(endpoint, function(statusCode, body)
        if statusCode == 200 then
            local data = json.decode(body)
            local roles = {}
            for _, role in ipairs(data.roles) do
                roles[role] = true
            end
            cb(roles)
        else
            print("Fout bij ophalen Discord rollen: "..tostring(statusCode))
            cb(nil)
        end
    end, 'GET', '', { ['Authorization'] = "Bot "..Config.BotToken, ['Content-Type'] = 'application/json' })
end

function GetHighestRole(roles)
    for _, roleName in ipairs(Config.RolePriority) do
        local roleId = Config.RoleIDs[roleName]
        if roles and roles[roleId] then
            return roleName
        end
    end
    return "Geen Speciale Rol"
end