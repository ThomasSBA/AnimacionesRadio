local expectedResourceName = 'thom_animradio'
local actualResourceName = GetCurrentResourceName()

if actualResourceName ~= expectedResourceName then
    print(('🛑 Este recurso fue renombrado (%s). Deteniendo ejecución.'):format(actualResourceName, expectedResourceName))
    return
end

local QBCore = exports['qb-core']:GetCoreObject()
local selectedEmote = 'radio'
local wasTalking = false

CreateThread(function()
    while true do
        Wait(150)

        local isTalking = LocalPlayer.state.radioActive or false

        if isTalking and not wasTalking then
            wasTalking = true
            if selectedEmote then
                ClearPedTasks(PlayerPedId())
                Wait(100)
                exports['rpemotes-reborn']:EmoteCommandStart(selectedEmote, 0)
            else
                print("⚠️ No hay emote seleccionado. ⚠️")
            end
        elseif not isTalking and wasTalking then
            wasTalking = false
            exports['rpemotes-reborn']:EmoteCancel(false)
        end
    end
end)

RegisterCommand(Config.CommandName, function()
    OpenRadioMenu()
end, false)

RegisterKeyMapping(Config.CommandName, 'Abrir menú de animaciones de radio', 'keyboard', Config.MenuKey)

function OpenRadioMenu()
    local options = {
        { header = '🎙️ Menú de Animaciones de Radio 🎙️', isMenuHeader = true }
    }

    for _, anim in pairs(Config.RadioEmotes) do
        table.insert(options, {
            header = anim.label,
            txt = '✅ Seleccionar esta animación',
            params = {
                event = 'radioanim:setEmote',
                args = anim.emote
            }
        })
    end

    exports['qb-menu']:openMenu(options)
end

RegisterNetEvent('radioanim:setEmote', function(emoteName)
    if GetCurrentResourceName() ~= expectedResourceName then
        print('🚨 Intento de ejecutar evento desde un recurso renombrado.')
        return
    end

    selectedEmote = emoteName
    QBCore.Functions.Notify('✅ Animación seleccionada: ' .. emoteName, 'success')
end)
