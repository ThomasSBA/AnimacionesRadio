local expectedResourceName = 'thom_animradio'
local actualResourceName = GetCurrentResourceName()

if actualResourceName ~= expectedResourceName then
    print(('🛑 Este recurso fue renombrado (%s). Deteniendo ejecución.'):format(actualResourceName, expectedResourceName))
    return
end

local QBCore = exports['qb-core']:GetCoreObject()
local selectedEmote = 'radio'
local wasTalking = false

-- Detección de voz por radio
CreateThread(function()
    while true do
        Wait(150)
        local isTalking = LocalPlayer.state.radioActive or false

        if isTalking and not wasTalking then
            wasTalking = true
            if selectedEmote then
                ClearPedTasks(PlayerPedId())
                Wait(100)
                ExecuteCommand("e " .. selectedEmote)
            end
        elseif not isTalking and wasTalking then
            wasTalking = false
            ExecuteCommand("e c")
        end
    end
end)

-- Comando y key mapping
RegisterCommand(Config.CommandName, function()
    OpenRadioMenu()
end, false)

RegisterKeyMapping(Config.CommandName, 'Abrir menú de animaciones de radio', 'keyboard', Config.MenuKey)

-- Abrir menú con qb-menu
function OpenRadioMenu()
    local options = {
        { header = '🎙️ Menú de Animaciones de Radio 🎙️', isMenuHeader = true }
    }

    for _, anim in pairs(Config.RadioEmotes or {}) do
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

-- Evento para setear la animación seleccionada
RegisterNetEvent('radioanim:setEmote', function(emoteName)
    selectedEmote = emoteName

    -- Buscar el label correspondiente al emote
    local emoteLabel = emoteName
    for _, anim in pairs(Config.RadioEmotes) do
        if anim.emote == emoteName then
            emoteLabel = anim.label
            break
        end
    end

    QBCore.Functions.Notify('✅ Animación seleccionada: ' .. emoteLabel, 'success')
end)