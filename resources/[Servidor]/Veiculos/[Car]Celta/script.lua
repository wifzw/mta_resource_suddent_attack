-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( '507.txd' ) 
engineImportTXD( txd, 421 ) 
dff = engineLoadDFF('507.dff', 421) 
engineReplaceModel( dff, 421 )
end)
