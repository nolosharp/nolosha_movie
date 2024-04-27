RegisterNetEvent('showYouTubeVideo')
AddEventHandler('showYouTubeVideo', function(url)
    SendNUIMessage({
        action = "showVideo",
        videoUrl = url
    })
end)

RegisterNetEvent('playYouTubeVideo')
AddEventHandler('playYouTubeVideo', function(videoUrl)
    SendNUIMessage({
        action = "showVideo",
        videoUrl = videoUrl
    })
end)

RegisterNUICallback('hideYouTubeVideoUI', function()
    ExecuteCommand('hideUi')
end)
