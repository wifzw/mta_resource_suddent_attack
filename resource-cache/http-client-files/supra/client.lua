function Arac()
    local txd = engineLoadTXD ('arac.txd')
    engineImportTXD(txd,562)
    local dff = engineLoadDFF('arac.dff',562)
    engineReplaceModel(dff,562)
end
addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),Arac)



-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy