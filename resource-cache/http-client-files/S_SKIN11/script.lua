txd = engineLoadTXD( '1.txd' )
engineImportTXD( txd, 46 )
dff = engineLoadDFF('1.dff', 46)
engineReplaceModel( dff, 46 )