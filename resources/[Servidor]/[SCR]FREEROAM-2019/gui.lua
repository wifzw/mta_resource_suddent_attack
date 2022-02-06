local CONTROL_MARGIN_RIGHT = 5
local LINE_MARGIN = 5
local LINE_HEIGHT = 16
local g_gridListContents = {}   
local g_openedWindows = {}      
local g_protectedElements = {}
local GRIDLIST_UPDATE_CHUNK_SIZE = 10
windowRenkR = 255
windowRenkG = 109
windowRenkB = 0
butonRenkR = 255
butonRenkG = 109
butonRenkB = 0
local classInfo = {
	wnd = {className = 'Window', padding = {40, 10, 10, 10}, isContainer = true},
	tbp = {className = 'TabPanel'},
	tab = {className = 'Tab', padding = 10, isContainer = true},
	lbl = {className = 'Label', height = 20},
	btn = {className = 'Button', height = 20, padding = {3, 4}},
	chk = {className = 'CheckBox', height = 20, padding = {0, 6}},
	rad = {className = 'RadioButton', height = 20, padding = {0, 10}},
	txt = {className = 'Edit', width=100, height = 24},
	lst = {className = 'GridList', width = 250, height = 400},
	img = {className = 'StaticImage'}
}
function createWindow(wnd, rebuild)
	if wnd.element then
		if rebuild then
			destroyElement(wnd.element)
		else
			guiSetVisible(wnd.element, true)
			guiBringToFront(wnd.element)
			g_openedWindows[wnd] = true
			if wnd.oncreate then
				wnd.oncreate()
			end
			return
		end
	end
	_planWindow(wnd)
	_buildWindow(wnd)
end
local function onProtectedClick(btn,state,x,y)
	if isFunctionOnCD(g_protectedElements[source]) then return end
	g_protectedElements[source](btn,state,x,y)

end
function _planWindow(wnd, baseWnd, parentWnd, x, y, maxHeightInLine)
	local wndClass = wnd[1]
	if not maxHeightInLine then
		maxHeightInLine = LINE_HEIGHT
	end
	local text, padding, parentPadding
	if wndClass ~= 'br' then
		padding = classInfo[wndClass].padding
		if type(padding) == 'number' then
			padding = table.rep(padding, 4)
			classInfo[wndClass].padding = padding
		elseif type(padding) == 'table' then
			if #padding == 1 then
				padding = table.rep(padding[1], 4)
				classInfo[wndClass].padding = padding
			elseif #padding == 2 then
				padding = table.flatten(table.rep(padding, 2))
				classInfo[wndClass].padding = padding
			elseif #padding == 3 then
				table.insert(padding, padding[2])
				classInfo[wndClass].padding = padding
			end
		elseif not padding then
			padding = table.rep(0, 4)
			classInfo[wndClass].padding = padding
		end
		text = wnd.text or wnd.id or ''
		if not wnd.width then
			wnd.width = (classInfo[wndClass].width or (8*text:len()) + (not classInfo[wndClass].isContainer and (padding[2] + padding[4]) or 0))
		end
		if not wnd.height and not classInfo[wndClass].isContainer then
			wnd.height = (classInfo[wndClass].height or LINE_HEIGHT) + padding[1] + padding[3]
		end
	end
	parentPadding = parentWnd and classInfo[parentWnd[1]].padding
	if wndClass == 'br' or (not classInfo[wndClass].isContainer and x + wnd.width > parentWnd.width - parentPadding[2]) then
		x = parentPadding[4]
		y = y + maxHeightInLine + LINE_MARGIN
		maxHeightInLine = LINE_HEIGHT
		if wndClass == 'br' then
			return nil, x, y, maxHeightInLine
		end
	end
	if not wnd.x then
		wnd.x = x
	end
	if not wnd.y then
		wnd.y = y
	end
	wnd.parent = parentWnd
	if wnd.controls then
		local childX, childY = padding[4], padding[1]
		local childMaxHeightInLine = LINE_HEIGHT
		local control
		for id, controlwnd in pairs(wnd.controls) do
			control, childX, childY, childMaxHeightInLine = _planWindow(controlwnd, baseWnd or wnd, wnd, childX, childY, childMaxHeightInLine)
		end
		if classInfo[wndClass].isContainer then
			wnd.height = childY + childMaxHeightInLine + padding[3]
		end
	end
	if wnd.tabs then
		local maxTabHeight = 0
		for id, tab in pairs(wnd.tabs) do
			tab[1] = 'tab'
			tab.width = wnd.width
			_planWindow(tab, baseWnd, wnd)
			if tab.height > maxTabHeight then
				maxTabHeight = tab.height
			end
		end
		wnd.height = maxTabHeight
	end
	if classInfo[wndClass].isContainer then
		return elem
	else
		if wnd.height > maxHeightInLine then
			maxHeightInLine = wnd.height
		end
		return elem, x + wnd.width + CONTROL_MARGIN_RIGHT, y, maxHeightInLine
	end
end
function _buildWindow(wnd, baseWnd, parentWnd)
	local wndClass = wnd[1]
	if wndClass == 'br' then
		return
	end
	local relX, relY, relWidth, relHeight
	if parentWnd then
		if wnd.x and wnd.y then
			relX = wnd.x/parentWnd.width
			relY = wnd.y/parentWnd.height
		end
		relWidth = wnd.width / parentWnd.width
		relHeight = wnd.height / parentWnd.height
	end
	local elem
	if wndClass == 'wnd' then
		local screenWidth, screenHeight = guiGetScreenSize()
		if not wnd.x then
			wnd.x = screenWidth/2 - wnd.width/2
		else
			local i, f = math.modf(wnd.x)
			if f ~= 0 then
				wnd.x = screenWidth * wnd.x
			end
			if wnd.x < 0 then
				wnd.x = screenWidth - math.abs(wnd.x) - wnd.width
			end
		end
		if not wnd.y then
			wnd.y = screenHeight/2 - wnd.height/2
		else
			local i, f = math.modf(wnd.y)
			if f ~= 0 then
				wnd.y = screenHeight * wnd.y
			end
			if wnd.y < 0 then
				wnd.y = screenHeight - math.abs(wnd.y) - wnd.height
			end
		end
		elem = guiCreateWindow(wnd.x, wnd.y, wnd.width, wnd.height, wnd.text, false)
		guiBringToFront(elem)
		g_openedWindows[wnd] = true
	elseif wndClass == 'chk' then
		elem = guiCreateCheckBox(relX, relY, relWidth, relHeight, wnd.text or wnd.id or '', false, true, parentWnd.element)
	elseif wndClass == 'tbp' then
		elem = guiCreateTabPanel(relX, relY, relWidth, relHeight, true, parentWnd.element)
	elseif wndClass == 'tab' then
		elem = guiCreateTab(text, parentWnd.element)
	elseif wndClass == 'lst' then
		elem = guiCreateGridList(relX, relY, relWidth, relHeight, true, parentWnd.element)
		if wnd.columns then
			guiGridListSetSortingEnabled(elem, false)
			for i, column in ipairs(wnd.columns) do
				guiGridListAddColumn(elem, column.text or column.attr or '', column.width or 0.9)
			end
		end
	elseif wndClass == 'img' then
		elem = guiCreateStaticImage(relX, relY, relWidth, relHeight, wnd.src or '', true, parentWnd.element)
	elseif wndClass == 'btn' then
	    elem = butonOlustur(relX, relY, relWidth, relHeight, wnd.text or wnd.id or 'Boş',wnd.r or butonRenkR,wnd.g or butonRenkG,wnd.b or butonRenkB,parentWnd.element)
	else
		elem = _G['guiCreate' .. classInfo[wndClass].className](relX, relY, relWidth, relHeight, wnd.text or wnd.id or '', true, parentWnd.element)
		Fonte = guiCreateFont("font.otf", 9)
		guiSetFont( elem, Fonte )
		if wnd.align and wndClass == 'lbl' then
			guiLabelSetHorizontalAlign(elem, wnd.align, true)
		end
	end
	wnd.element = elem
	if wnd.controls then
		for id, controlwnd in pairs(wnd.controls) do
			_buildWindow(controlwnd, baseWnd or wnd, wnd)
		end
	end
	if wnd.tabs then
		for id, tab in pairs(wnd.tabs) do
			_buildWindow(tab, baseWnd, wnd)
		end
	end
	if wnd.rows then
		if wnd.rows.xml then
			bindGridListToTable(wnd, not gridListHasCache(wnd) and xmlToTable(wnd.rows.xml, wnd.rows.attrs) or false,
				wnd.expandlastlevel or wnd.expandlastlevel == nil)
		else
			bindGridListToTable(wnd, not gridListHasCache(wnd) and wnd.rows or false, false)
		end
	end
	local clickhandler = nil
	if wnd.onclick then
		if wndClass == 'img' then
			clickhandler = function(btn, state, x, y)
				local imgX, imgY = getControlScreenPos(wnd)
				wnd.onclick((x - imgX)/wnd.width, (y - imgY)/wnd.height, btn)
			end
		else
			clickhandler = function() wnd.onclick() end
		end
	elseif wnd.window then
		clickhandler = function() toggleWindow(wnd.window) end
	elseif wnd.inputbox then
		clickhandler = function()
			wndInput = {
				'wnd',
				width = 170,
				height = 60,
				controls = {
					{'txt', id='input', text='', width=60},
					{'btn', id='ok', onclick=function() wnd.inputbox.callback(getControlText(wndInput, 'input')) closeWindow(wndInput) end},
					{'btn', id='cancel', closeswindow=true}
				}
			}
			for propname, propval in pairs(wnd.inputbox) do
				wndInput[propname] = propval
			end
			createWindow(wndInput)
			guiBringToFront(getControl(wndInput, 'input'))
		end
	elseif wnd.closeswindow then
		clickhandler = function() closeWindow(baseWnd) end
	end
	if clickhandler then
		if wnd.ClickSpamProtected then
			g_protectedElements[elem] = clickhandler
			addEventHandler('onClientGUIClick', elem, onProtectedClick, false)
		else
			addEventHandler('onClientGUIClick', elem, clickhandler, false)
		end
	end
	if wnd.ondoubleclick then
		local doubleclickhandler
		if wndClass == 'img' then
			doubleclickhandler = function(btn, state, x, y)
				local imgX, imgY = getControlScreenPos(wnd)
				wnd.ondoubleclick((x - imgX)/wnd.width, (y - imgY)/wnd.height)
			end
		else
			doubleclickhandler = wnd.ondoubleclick
		end
		if wnd.DoubleClickSpamProtected then
			g_protectedElements[elem] = doubleclickhandler
			addEventHandler('onClientGUIDoubleClick', elem, onProtectedClick, false)
		else
			addEventHandler('onClientGUIDoubleClick', elem, doubleclickhandler, false)
		end
	end
	if wnd.oncreate then
		wnd.oncreate()
	end
end
function isWindowOpen(wnd)
	return wnd.element and guiGetVisible(wnd.element)
end
function getControlScreenPos(wnd)
	local x, y = 0, 0
	local curX, curY
	local curWnd = wnd
	while curWnd do
		curX, curY = guiGetPosition(curWnd.element, false)
		x = x + curX
		y = y + curY
		curWnd = curWnd.parent
	end
	return x, y
end
function closeWindow(...)
	local args = { ... }
	for i=1,#args do
		g_openedWindows[args[i]] = nil
		if not args[i].element then
			return
		end

		if args[i].onclose then
			args[i].onclose()
		end
		guiSetVisible(args[i].element, false)
	end
	if not isAnyWindowOpen() then
		showCursor(false)
	end
end
function toggleWindow(...)
	local args = { ... }
	for i=1,#args do
		if isWindowOpen(args[i]) then
			closeWindow(args[i])
		else
			createWindow(args[i])
		end
	end
end
function isAnyWindowOpen()
	for wnd,_ in pairs(g_openedWindows) do
		if isWindowOpen(wnd) then
			return true
		end
	end
	return false
end
function hideAllWindows()
	for wnd,_ in pairs(g_openedWindows) do
		guiSetVisible(wnd.element, false)
	end
end
function showAllWindows()
	for wnd,_ in pairs(g_openedWindows) do
		guiSetVisible(wnd.element, true)
	end
end
function showControls(wnd, ...)
	for i,ctrlName in ipairs({ ... }) do
		guiSetVisible(getControl(wnd, ctrlName), true)
	end
end
function hideControls(wnd, ...)
	for i,ctrlName in ipairs({ ... }) do
		guiSetVisible(getControl(wnd, ctrlName), false)
	end
end
function getControlData(...)
	local lookIn
	local currentData
	local args = { ... }
	if type(args[1]) == 'string' then
		currentData = _G[args[1]]
	else
		currentData = args[1]
	end
	for i=2,#args do
		if args[i] == '..' then
			currentData = currentData.parent
		else
			lookIn = currentData.controls or currentData.tabs
			if not lookIn then
				return false
			end
			currentData = false
			for j,control in pairs(lookIn) do
				if control.id == args[i] then
					currentData = control
					break
				end
			end
			if not currentData then
				return false
			end
		end
	end
	return currentData
end
function getControl(...)
	if type(({...})[1]) == 'userdata' then
		return ({...})[1]
	end
	local data = getControlData(...)
	if not data then
		return false
	end
	return data.element
end
function getControlText(...)
	return guiGetText(getControl(...))
end
function getControlNumber(...)
	return tonumber(guiGetText(getControl(...)))
end
function getControlNumbers(...)
	local args = {...}
	local controlnames = table.remove(args)
	local result = {}
	for i,name in ipairs(controlnames) do
		result[i] = getControlNumber(unpack(args), name)
	end
	return unpack(result)
end
function setControlText(...)
	local args = {...}
	local text = table.remove(args)
	local element = getControl(unpack(args))
	if (element and isElement(element) and text) then
		guiSetText(element, text)
	end
end
function setControlNumber(...)
	local args = {...}
	local num = table.remove(args)
	guiSetText(getControl(unpack(args)), tostring(num))
end
function setControlNumbers(...)
	local args = {...}
	local controlvalues = table.remove(args)
	for name,value in pairs(controlvalues) do
		setControlNumber(unpack(args), name, value)
	end
end
function getControlBaseWindow(...)
	local control = getControlData(...)
	while control.parent do
		control = control.parent
	end
	return control
end
function appendControl(...)
	local args = {...}
	local newChild = table.remove(args)
	local parent = getControlData(unpack(args))
	if not parent.controls then
		parent.controls = {}
	end
	table.insert(parent.controls, newChild)
	local wnd = getControlBaseWindow(parent)
	local visible = isWindowOpen(wnd)
	createWindow(wnd, true)
	if not visible then
		guiSetVisible(wnd.element, false)
	end
	return newChild.element
end
function getSelectedGridListData(...)
	local list = getControl(...)
	local selID = guiGridListGetSelectedItem(list)
	if not selID then
		return false
	end
	return guiGridListGetItemData(list, selID, 1), selID
end
function getSelectedGridListItem(...)
	local list
	local column
	local args = {...}
	if type(arg[arg.n]) == 'number' then
		column = table.remove(args)
	else
		column = 1
	end
	list = getControl(unpack(args))
	local selID = guiGridListGetSelectedItem(list)
	if not selID then
		return false
	end
	return guiGridListGetItemText(list, selID, column), selID
end
function getSelectedGridListLeaf(...)
	local listControl = getControlData(...)
	local selData = getSelectedGridListData(listControl.element)
	if not selData then
		return false
	end
	local listdata = g_gridListContents[listControl]
	return followTreePath(listdata.data, listdata.currentPath, table.map(string.split(selData, '/'), tonumber))
end
function bindGridListToTable(...)
	local args = {...}
	local expandLastLevel = table.remove(args)
	local t = table.remove(args)
	if t and not treeHasMetaInfo(t) then
		addTreeMetaInfo(t)
	end
	local gridListControlData = getControlData(unpack(args))
	local gridlist = gridListControlData.element
	local columns = table.merge({}, gridListControlData.columns, 'attr')
	local listdata = g_gridListContents[gridListControlData]
	if not listdata then
		listdata = {currentPath={}, data=t, columns=columns}
		if gridListControlData.pathlbl then
			listdata.pathlbl = getControl(gridListControlData, '..', gridListControlData.pathlbl)
		end
		g_gridListContents[gridListControlData] = listdata
	elseif t then
		listdata.data = t
		listdata.currentPath = {}
	end
	if not t then
		t = g_gridListContents[gridListControlData].data
	end
	_updateBindedGridList(gridlist, listdata, expandLastLevel)
	if not listdata.clickHandlersSet then
		if gridListControlData.onitemclick then
			if gridListControlData.ClickSpamProtected then
				addEventHandler('onClientGUIClick', gridlist,
					function()
						if isFunctionOnCD(gridListControlData.onitemclick) then return end
						local leaf = getSelectedGridListLeaf(gridListControlData)
						if leaf then
							gridListControlData.onitemclick(leaf)
						end
					end,
					false
				)
			else
				addEventHandler('onClientGUIClick', gridlist,
					function()
						local leaf = getSelectedGridListLeaf(gridListControlData)
						if leaf then
							gridListControlData.onitemclick(leaf)
						end
					end,
					false
				)
			end
		end
		addEventHandler('onClientGUIDoubleClick', gridlist,
			function()
				local listdata = g_gridListContents[gridListControlData]
				local previousGroup = followTreePath(listdata.data, listdata.currentPath)
				local selData, selRow = getSelectedGridListData(gridlist)
				if not selData then
					return
				end
				if tonumber(selData) == 0 then
					table.remove(listdata.currentPath)
				else
					local clickedNode = followTreePath(listdata.data, listdata.currentPath, table.map(string.split(selData, '/'), tonumber))
					if clickedNode[1] == 'group' then
						table.insert(listdata.currentPath, tonumber(selData))
					else
						if gridListControlData.onitemdoubleclick then
							if gridListControlData.DoubleClickSpamProtected then
								if isFunctionOnCD(gridListControlData.onitemdoubleclick) then return end
								gridListControlData.onitemdoubleclick(clickedNode, selRow)
							else
								gridListControlData.onitemdoubleclick(clickedNode, selRow)
							end
						end
						return
					end
				end
				applyToLeaves(previousGroup, function(item) item.row = nil end)
				_updateBindedGridList(gridlist, listdata, expandLastLevel)
			end,
			false
		)
		listdata.clickHandlersSet = true
	end
	local modifiableCols = table.findall(gridListControlData.columns, 'enablemodify', true)
	if #modifiableCols then
		local mt = {
			__index = function(leaf, k)
				return leaf.shadow[k]
			end,
			__newindex =
				function(leaf, k, v)
					if k ~= 'row' and leaf.row then
						leaf.shadow[k] = v
						guiGridListSetItemText(gridlist, leaf.row, table.find(columns, k), type(v) == 'boolean' and (v and 'X' or '') or tostring(v), false, false)
						guiSetAlpha(gridlist, guiGetAlpha(gridlist))	-- force repaint
					else
						rawset(leaf, k, v)
					end
				end
		}
		local attr
		applyToLeaves(t,
			function(leaf)
				if not leaf.shadow then
					leaf.shadow = {}
					for i,index in ipairs(modifiableCols) do
						attr = gridListControlData.columns[index].attr
						leaf.shadow[attr] = leaf[attr]
						leaf[attr] = nil
					end
				end
				setmetatable(leaf, mt)
			end
		)
	end
end
function gridListHasCache(...)
	local listControl = getControlData(...)
	return g_gridListContents[listControl] and true or false
end
function getGridListCache(...)
	local listControl = getControlData(...)
	return g_gridListContents[listControl] and g_gridListContents[listControl].data
end
function resetGridListPath(...)
	g_gridListContents[getControlData(...)].currentPath = {}
end
function _updateBindedGridList(gridlist, listdata, expandLastLevel, isContinuation)
	local group = followTreePath(listdata.data, listdata.currentPath)
	local toDisplay = group.children or group
	if not isContinuation then
		if _updateGridListOnFrame then
			_removeGridListFrameUpdate(listdata)
		end
		guiGridListClear(gridlist)
		if not expandLastLevel and toDisplay[1][1] ~= 'group' then
			_updateGridListOnFrame = function()
				_updateBindedGridList(gridlist, listdata, false, true)
			end
			addEventHandler('onClientRender', getRootElement(), _updateGridListOnFrame)
		end
		if listdata.pathlbl then
			guiSetText(listdata.pathlbl, treePathToString(listdata.data, listdata.currentPath))
		end
		if #(listdata.currentPath) > 0 then
			guiGridListAddRow(gridlist)
			guiGridListSetItemText(gridlist, 0, 1, '..', false, false)
			guiGridListSetItemData(gridlist, 0, 1, '0')
		end
	end
	local rowID, leafRowID
	if expandLastLevel or toDisplay[1][1] == 'group' then
		for i,item in ipairs(toDisplay) do
			if type(item) == 'table' then
				rowID = guiGridListAddRow(gridlist)
				if item[1] == 'group' then
					if expandLastLevel and (listdata.data.maxSubDepth == 2 or item.depth > 1) and item.maxSubDepth == item.depth + 1 then
						guiGridListSetItemText(gridlist, rowID, 1, item.name, false, false)
						for j,leaf in ipairs(item.children) do
							leafRowID = guiGridListAddRow(gridlist)
							_putLeafInGridListRow(gridlist, leafRowID, leaf, listdata.columns)
							guiGridListSetItemData(gridlist, leafRowID, 1, i .. '/' .. j)
							leaf.row = leafRowID
						end
					else
						guiGridListSetItemText(gridlist, rowID, 1, '+ ' .. item.name, false, false)
					end
				else
					_putLeafInGridListRow(gridlist, rowID, item, listdata.columns)
				end
				guiGridListSetItemData(gridlist, rowID, 1, tostring(i))
				item.row = rowID
			end
		end
	else
		local startIndex = listdata.nextChunkStartIndex or 1
		local endIndex = math.min(startIndex + GRIDLIST_UPDATE_CHUNK_SIZE - 1, #toDisplay)
		for i=startIndex,endIndex do
			rowID = guiGridListAddRow(gridlist)
			_putLeafInGridListRow(gridlist, rowID, toDisplay[i], listdata.columns)
			guiGridListSetItemData(gridlist, rowID, 1, tostring(i))
			toDisplay[i].row = rowID
		end
		if endIndex == #toDisplay then
			_removeGridListFrameUpdate(listdata)
		else
			listdata.nextChunkStartIndex = endIndex + 1
		end
	end
end
function _putLeafInGridListRow(gridlist, row, leaf, columnAttrs)
	for k,attr in ipairs(columnAttrs) do
		guiGridListSetItemText(gridlist, row, k, type(leaf[attr]) == 'boolean' and (leaf[attr] and 'X' or '') or ('    ' .. tostring(leaf[attr])), false, false)
	end
end
function _removeGridListFrameUpdate(listdata)
	removeEventHandler('onClientRender', getRootElement(), _updateGridListOnFrame)
	listdata.nextChunkStartIndex = nil
	_updateGridListOnFrame = nil
end