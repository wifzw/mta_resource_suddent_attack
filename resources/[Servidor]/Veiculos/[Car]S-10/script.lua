-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( '579.txd' ) 
engineImportTXD( txd, 579 ) 
dff = engineLoadDFF('579.dff', 579) 
engineReplaceModel( dff, 579 )
end)
