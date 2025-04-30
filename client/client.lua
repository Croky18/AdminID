local roleDisplays = {}

RegisterNetEvent('discordroles:client:showRoleForAll', function(playerId, role)
    roleDisplays[playerId] = {
        role = role,
        timeout = GetGameTimer() + 10000
    }
end)

CreateThread(function()
    while true do
        Wait(0)
        for id, data in pairs(roleDisplays) do
            local ped = GetPlayerPed(GetPlayerFromServerId(id))
            if ped and DoesEntityExist(ped) then
                local coords = GetEntityCoords(ped)
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(coords - playerCoords)

                if GetGameTimer() < data.timeout and distance <= 15.0 then
                    DrawText3D(coords.x, coords.y, coords.z + 1.2, data.role)
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local scale = Config.TextOptions.Scale

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(Config.TextOptions.Font)
        SetTextProportional(1)
        SetTextColour(
            Config.TextOptions.Color.r,
            Config.TextOptions.Color.g,
            Config.TextOptions.Color.b,
            Config.TextOptions.Color.a
        )
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)

        local factor = (string.len(text)) / 370
        DrawRect(
            _x,
            _y + 0.0125,
            0.015 + factor,
            0.03,
            Config.TextOptions.Background.r,
            Config.TextOptions.Background.g,
            Config.TextOptions.Background.b,
            Config.TextOptions.Background.a
        )
    end
end