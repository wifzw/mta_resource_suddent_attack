-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'rdtrain.txd' ) 
engineImportTXD( txd, 515 ) 
dff = engineLoadDFF('rdtrain.dff', 515) 
engineReplaceModel( dff, 515 )
end)
