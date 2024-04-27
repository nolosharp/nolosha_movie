local VORPcore = exports.vorp_core:GetCore() -- top of your client/server files


local authorizedJobs = {
    "gouverneur",
    "admin",
    -- Ajoutez d'autres jobs autorisés ici
}

local requiredItem = "bluecard"  -- Item requis pour voir la vidéo avec la commande

local itemVideoMappings = {
    ["video_item_1"] = "_02iJ9c0kug",
    ["video_item_2"] = "qXOZIAiaFL4",
    ["Pillule_chat"] = "_02iJ9c0kug",
    ["vhs_sterling"] = "pusO-rmIQjI",
    ["vhs_sterling1"] = "11r2tZ_I81o",
    -- Ajoutez d'autres items et vidéos ici
}

function isAuthorizedJob(job)
    for _, authorizedJob in pairs(authorizedJobs) do
        if job == authorizedJob then
            return true
        end
    end
    return false
end

function playerHasItem(source, itemName)
    local userInventory = exports.vorp_inventory:getUserInventoryItems(source)
    for _, item in pairs(userInventory) do
        if item.name == itemName then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    for itemName, videoUrl in pairs(itemVideoMappings) do
        exports.vorp_inventory:registerUsableItem(itemName, function(data)
            TriggerClientEvent('playYouTubeVideo', data.source, videoUrl)
        end)
    end
end)

RegisterCommand("playvideo", function(source, args, rawCommand)
    local User = VORPcore.getUser(source)
    local Character = User.getUsedCharacter
    local playerJob = Character.job

    if isAuthorizedJob(playerJob) then
        local target = args[1]
        local videoUrl = args[2]

        if videoUrl then
            if target == "all" then
                TriggerClientEvent('showYouTubeVideo', -1, videoUrl)
            elseif target == "item" then
                for _, playerId in ipairs(GetPlayers()) do
                    if playerHasItem(playerId, requiredItem) then
                        TriggerClientEvent('showYouTubeVideo', playerId, videoUrl)
                    end
                end
            else
                local targetId = tonumber(target)
                if targetId then
                    TriggerClientEvent('showYouTubeVideo', targetId, videoUrl)
                else
                    TriggerClientEvent("vorp:TipBottom", source, "ID de joueur invalide.", 4000)
                end
            end
        else
            TriggerClientEvent("vorp:TipBottom", source, "Vous devez spécifier une URL de vidéo YouTube.", 4000)
        end
    else
        TriggerClientEvent("vorp:TipBottom", source, "Vous n'avez pas la permission d'utiliser cette commande.", 4000)
    end
end, false)
