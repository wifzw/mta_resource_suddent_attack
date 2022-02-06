--By Reventon

function AracYukle440()
    local txd = engineLoadTXD ('Dosyalar/1.txd')
    engineImportTXD(txd,440)
    local dff = engineLoadDFF('Dosyalar/2.dff',440)
    engineReplaceModel(dff,440)
end
addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),AracYukle440)

--By Reventon