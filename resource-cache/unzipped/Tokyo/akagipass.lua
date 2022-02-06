function map()
	txd = engineLoadTXD ( "commercial.txd" )
	engineImportTXD ( txd, 2360)
	engineImportTXD ( txd, 2361)
	engineImportTXD ( txd, 2362)
	engineImportTXD ( txd, 2363)
	engineImportTXD ( txd, 2364)
	engineImportTXD ( txd, 2365)
	engineImportTXD ( txd, 2366)
	engineImportTXD ( txd, 2367)
	engineImportTXD ( txd, 2368)
	engineImportTXD ( txd, 2369)

	
    col = engineLoadCOL ( "commercial1.col" )
	col1 = engineLoadCOL ( "commercial2.col" )
	col2 = engineLoadCOL ( "commercial3.col" )
	col3 = engineLoadCOL ( "commercial4.col" )
	col4 = engineLoadCOL ( "commercial5.col" )
	col5 = engineLoadCOL ( "commercial6.col" )
	col6 = engineLoadCOL ( "commercial7.col" )
	col7 = engineLoadCOL ( "commercial8.col" )
	col8 = engineLoadCOL ( "commercial9.col" )
	col9 = engineLoadCOL ( "commercial10.col" )


	dff = engineLoadDFF ( "commercial1.dff", 0 )
	dff1 = engineLoadDFF ( "commercial2.dff", 0 )
	dff2 = engineLoadDFF ( "commercial3.dff", 0 )
	dff3 = engineLoadDFF ( "commercial4.dff", 0 )
	dff4 = engineLoadDFF ( "commercial5.dff", 0 )
	dff5 = engineLoadDFF ( "commercial6.dff", 0 )
	dff6 = engineLoadDFF ( "commercial7.dff", 0 )
	dff7 = engineLoadDFF ( "commercial8.dff", 0 )
	dff8 = engineLoadDFF ( "commercial9.dff", 0 )
	dff9 = engineLoadDFF ( "commercial10.dff", 0 )


	engineReplaceCOL ( col, 2360)
	engineReplaceCOL ( col1, 2361)
	engineReplaceCOL ( col2, 2362)
	engineReplaceCOL ( col3, 2363)
	engineReplaceCOL ( col4, 2364)
	engineReplaceCOL ( col5, 2365)
	engineReplaceCOL ( col6, 2366)
	engineReplaceCOL ( col7, 2367)
	engineReplaceCOL ( col8, 2368)
	engineReplaceCOL ( col9, 2369)



	engineReplaceModel ( dff, 2360)
	engineReplaceModel ( dff1, 2361)
	engineReplaceModel ( dff2, 2362)
	engineReplaceModel ( dff3, 2363)
	engineReplaceModel ( dff4, 2364)
	engineReplaceModel ( dff5, 2365)
	engineReplaceModel ( dff6, 2366)
	engineReplaceModel ( dff7, 2367)
	engineReplaceModel ( dff8, 2368)
	engineReplaceModel ( dff9, 2369)



	engineSetModelLODDistance(2360,2000)
	engineSetModelLODDistance(2361,2000)
	engineSetModelLODDistance(2362,2000)
	engineSetModelLODDistance(2363,2000)
	engineSetModelLODDistance(2364,2000)
	engineSetModelLODDistance(2365,2000)
	engineSetModelLODDistance(2366,2000)
	engineSetModelLODDistance(2367,2000)
	engineSetModelLODDistance(2368,2000)
	engineSetModelLODDistance(2369,2000)




end

setTimer ( map, 1000, 1)


addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
	engineRestoreCOL(2360)
	engineRestoreCOL(2361)
	engineRestoreCOL(2362)
	engineRestoreCOL(2363)
	engineRestoreCOL(2364)
	engineRestoreCOL(2365)
	engineRestoreCOL(2366)
	engineRestoreCOL(2367)
	engineRestoreCOL(2368)
	engineRestoreCOL(2369)


	engineRestoreModel(2360)
	engineRestoreModel(2361)
	engineRestoreModel(2362)
	engineRestoreModel(2363)
	engineRestoreModel(2364)
	engineRestoreModel(2365)
	engineRestoreModel(2366)
	engineRestoreModel(2367)
	engineRestoreModel(2368)
	engineRestoreModel(2369)

	
		destroyElement(dff)
		destroyElement(dff1)
		destroyElement(dff2)
		destroyElement(dff3)
		destroyElement(dff4)
		destroyElement(dff5)
		destroyElement(dff6)
		destroyElement(dff7)
		destroyElement(dff8)
		destroyElement(dff9)



		destroyElement(col)
		destroyElement(col1)
		destroyElement(col2)
		destroyElement(col3)
		destroyElement(col4)
		destroyElement(col5)
		destroyElement(col6)
		destroyElement(col7)
		destroyElement(col8)
		destroyElement(col9)


		destroyElement(txd)


	end
)

createObject ( 2360, 4203, -5619.7998, 1.9 )
createObject ( 2361, 4203.1001, -5763.5, 1.91 )
createObject ( 2362, 4059.19995, -5763.4502, 1.912 )
createObject ( 2363, 4059.15991, -5907.55078, 1.912 )
createObject ( 2364, 4202.62988, -5907.89014, 1.9 )
createObject ( 2366, 173.5, 179.7998, 430.10001 )
createObject ( 2367, 4059.12012, -5619.5332, 1.9116 )
createObject ( 2368, 4059.19995, -5446.1792, 1.912 )
createObject ( 2369, 4203, -5475.75977, 1.899 )
createObject ( 2365, 4059.19995, -5331.37988, 1.92 )
createObject ( 2360, 4203, -5331.72021, 1.89999 )