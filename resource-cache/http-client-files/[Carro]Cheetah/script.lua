-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'CHEETAH.txd' ) 
engineImportTXD( txd, 415 ) 
dff = engineLoadDFF('CHEETAH.dff', 415) 
engineReplaceModel( dff, 415 )
end)
