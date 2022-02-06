-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'fam1.txd' ) 
engineImportTXD( txd, 105 ) 
dff = engineLoadDFF('fam1.dff', 105) 
engineReplaceModel( dff, 105 )
end)
