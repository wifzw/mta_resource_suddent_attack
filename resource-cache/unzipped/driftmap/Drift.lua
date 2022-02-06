function importTextures3()
	txd = engineLoadTXD ( "Drift.txd" )
		engineImportTXD ( txd, 1836 )
	col = engineLoadCOL ( "Drift.col" )
	dff = engineLoadDFF ( "Drift.dff", 0 )
	engineReplaceCOL ( col, 1836 )
	engineReplaceModel ( dff, 1836 )
	engineSetModelLODDistance(1836, 2000)
end

setTimer ( importTextures3, 3000, 1)
--addCommandHandler("replace",importTextures3)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()
		engineRestoreCOL(1836)
		engineRestoreModel(1836)
		destroyElement(dff)
		destroyElement(col)
		destroyElement(txd)
	end
)
