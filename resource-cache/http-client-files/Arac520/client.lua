function Arac()
    local txd = engineLoadTXD ('arac.txd')
    engineImportTXD(txd,520)
    local dff = engineLoadDFF('arac.dff',520)
    engineReplaceModel(dff,520)
end
addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),Arac)


-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy