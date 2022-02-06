-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'CADRONA.txd' ) 
engineImportTXD( txd, 527 ) 
dff = engineLoadDFF('CADRONA.dff', 527) 
engineReplaceModel( dff, 527 )
end)
