-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( '507.txd' ) 
engineImportTXD( txd, 400 ) 
dff = engineLoadDFF('507.dff', 400) 
engineReplaceModel( dff, 400 )
end)
