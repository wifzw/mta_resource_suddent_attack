-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'hermes.txd' ) 
engineImportTXD( txd, 474 ) 
dff = engineLoadDFF('hermes.dff', 474) 
engineReplaceModel( dff, 474 )
end)
