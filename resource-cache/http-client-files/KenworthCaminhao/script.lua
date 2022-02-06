-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'petro.txd' ) 
engineImportTXD( txd, 403 ) 
dff = engineLoadDFF('petro.dff', 403) 
engineReplaceModel( dff, 403 )
end)
