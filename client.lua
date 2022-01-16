ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterNetEvent('tamma_nomi:mostraNomi')
AddEventHandler('tamma_nomi:mostraNomi', function()
    tammanomi = not tammanomi
    if tammanomi then
        tammanomi = true
        if not isShowingNames then startShowingNames() end
        ESX.ShowNotification('Nomi Attivati')
    else
        tammanomi = false
        ESX.ShowNotification('Nomi Disattivati')
    end
end)

startShowingNames = function()

    isShowingNames = true

    Citizen.CreateThread(function()
        local blips = {}

        while true do
            Citizen.Wait(1)
            for _, player in ipairs(GetActivePlayers()) do
                if GetPlayerPed(player) ~= GetPlayerPed(-1) then
                    ped = GetPlayerPed(player)
                    idTesta = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, GetPlayerName(player) .. " ["..GetPlayerServerId(player).."]", false, false, "", false)

                    if tammanomi then
                        N_0x63bb75abedc1f6a0(idTesta, 9, true)
                    else
                        --N_0x63bb75abedc1f6a0(idTesta, 9, false)
                        N_0x63bb75abedc1f6a0(idTesta, 0, false)
                    end

                    if not tammanomi then
                        isShowingNames = false

                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, false)
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 0, false)
                        
                        RemoveMpGamerTag(idTesta)

                        return
                    end
                end
            end
        end
    end)
end

