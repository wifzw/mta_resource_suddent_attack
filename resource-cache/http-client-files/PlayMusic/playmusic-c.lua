addEvent('onPlayerMusic', true)

addEventHandler('onPlayerMusic', root, function(nome_musica)
    local path = 'sfx/'..tostring(nome_musica)..'.mp3'
    outputChatBox(nome_musica)
    local sound = playSound(path)
    setSoundVolume(sound, 0.10)
end)