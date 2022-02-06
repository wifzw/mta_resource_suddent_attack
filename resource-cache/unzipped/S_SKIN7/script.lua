txd = engineLoadTXD( '1.txd' )
engineImportTXD( txd, 40 )
dff = engineLoadDFF('1.dff', 40)
engineReplaceModel( dff, 40 )