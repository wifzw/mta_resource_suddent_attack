local button = {};
local label = {};
local progressbar = {};
moving = {};

function guiCreateProgressBar(x, y, w, h, relative, parent)
	
	if (x and y) then
		local back = guiCreateStaticImage(x, y, w, h, "cegui/image/pback.png", relative, parent);
		local front = guiCreateStaticImage(2, 2, w - 4, h - 4, "cegui/image/pfront.png", relative, back);
		guiSetProperty(back, "ImageColours", "tl:FFa2d262 tr:FFa2d262 bl:FFa2d262 br:FFa2d262");
		guiSetProperty(front, "ImageColours", "tl:a2d26200 tr:a2d26200 bl:a2d26200 br:a2d26200");
		
		progressbar[front] = {};
		progressbar[front].width = w;
		progressbar[front].height = h;
		progressbar[front].value = 0;
		
		return front;
	end
	
end

function guiProgressBarSetProgress(element, float)
	if (not element) then return false; end
	progressbar[element].value = tonumber(float);
	guiSetSize(element, (float * progressbar[element].width) / 100, progressbar[element].height - 4, false);
end

function guiProgressBarGetProgress(element)
	return tonumber(progressbar[element].value);
end

function guiCreateWindow(x, y, w, h, text, relative, close)
	
	if (not close) then close = false; end
	
	if (x and y) then
		local background = guiCreateStaticImage(x, y, w, h, "cegui/image/background.png", relative);
		local topBackground = guiCreateStaticImage(0, 0, w, 25, "cegui/image/background.png", relative, background);
		guiSetProperty(background, "ImageColours", "tl:80000000 tr:80000000 bl:80000000 br:80000000");
		guiSetProperty(topBackground, "ImageColours", "tl:a2d26200 tr:a2d26200 bl:a2d26200 br:a2d26200");
		
		addEventHandler("onClientGUIMouseUp", topBackground,
			function()
				moving[topBackground] = false;
			end, false
		)
		
		addEventHandler("onClientGUIMouseDown", topBackground,
			function(button, cursorX, cursorY)
				if (button == "left") then
					if (not moving[topBackground]) then
						moving[topBackground] = true;
						local guiPos = {guiGetPosition(background, false)};
						local mouseX, mouseY = cursorX - guiPos[1], cursorY - guiPos[2];
						setPos = {mouseX, mouseY};
					end
				end
			end, false
		)
		
		addEventHandler("onClientCursorMove", root,
			function(_, _, cursorX, cursorY)
				if (moving[topBackground]) then
					guiSetPosition(background, cursorX - setPos[1], cursorY - setPos[2], false);
				end
			end, false
		)
		
		local title = guiCreateLabel(0, 0, w, 25, text, relative, topBackground);
		guiSetEnabled(title, false);
		guiSetFont(title, "default-bold-small");
		guiLabelSetHorizontalAlign(title, "center");
		guiLabelSetVerticalAlign(title, "center");
		guiBringToFront(title);
		
		if (close) then
			local imgClose = guiCreateStaticImage(w - 25, 0, 25, 25, "cegui/image/background.png", relative, topBackground);
			local btnClose = guiCreateLabel(w - 15, 4, 25, 25, "X", false, topBackground);
			guiSetFont(btnClose, "default-bold-small");
			guiBringToFront(btnClose);
			guiSetProperty(imgClose, "ImageColours", "tl:a2d26200 tr:a2d26200 bl:a2d26200 br:a2d26200");
			guiLabelSetColor(btnClose, 255, 255, 255);
			addEventHandler("onClientGUIClick", imgClose, closeWindow, false);
			addEventHandler("onClientMouseEnter", imgClose, hoverButton_closeDown, false);
			addEventHandler("onClientMouseLeave", imgClose, hoverButton_closeUp, false);
			button[imgClose] = background;
			setElementData(imgClose, "tooltip-text", "Fechar", false);
			setElementData(imgClose, "tooltip-background", "#4800FF", false);
		end
		
		return background;
	end
	
end

 --[[function guiCreateButton(x, y, w, h, text, relative, parent, hover, hColor)

	 if (not hover) then hover = false; end
	 if (not hColor) then hColor = "ff7FFF00"; end
	
	 if (x and y) then
		 local btnBackground = guiCreateStaticImage(x, y, w, h, "cegui/image/background.png", relative, parent);
		 guiSetProperty(btnBackground, "ImageColours", "tl:90000000 tr:90000000 bl:90000000 br:90000000");
		
		 if (hover) then
			 addEventHandler("onClientMouseEnter", btnBackground, 
				 function()
					 guiSetProperty(source, "ImageColours", "tl:"..hColor.." tr:"..hColor.." bl:"..hColor.." br:"..hColor.."");
				 end, false);
				
			 addEventHandler("onClientMouseLeave", btnBackground,
				 function()
					 guiSetProperty(source, "ImageColours", "tl:90000000 tr:90000000 bl:90000000 br:90000000");
				 end, false);
		 end
		
		 local btnTitle = guiCreateLabel(0, 0, w, h, text, relative, btnBackground);
		 guiSetEnabled(btnTitle, false);
		 guiSetFont(btnTitle, "default-bold-small");
		 guiLabelSetHorizontalAlign(btnTitle, "center");
		 guiLabelSetVerticalAlign(btnTitle, "center");
		 guiBringToFront(btnTitle);
		
		 return btnBackground;
	 end
	
 end--]]

function guiCreateEditt(x, y, w, h, text, relative, parent)
	
	if (x and y) then
		local edit = guiCreateEdit(x, y, w, h, text, relative, parent);
		guiSetAlpha(edit, 0);
		local editBackground = guiCreateStaticImage(x, y, w, h, "cegui/image/background.png", relative, parent);
		guiSetProperty(editBackground, "ImageColours", "tl:60FFFFFF tr:60FFFFFF bl:60FFFFFF br:60FFFFFF");
		guiSetEnabled(editBackground, false);
		
		local editTitle = guiCreateLabel(0 + 5, 0, w, h, text, relative, editBackground);
		guiSetFont(editTitle, "default-bold-small");
		guiBringToFront(editTitle);
		guiLabelSetColor(editTitle, 0, 0, 0);
		guiLabelSetVerticalAlign(editTitle, "center");
		
		addEventHandler("onClientGUIChanged", edit,
			function()
				local text = guiGetText(edit);
				guiSetText(editTitle, text);
			end, false
		)
		
		return edit;
	end
	
end

function closeWindow(btn)
	if (btn == "left") then
		guiSetVisible(button[source], false);
		showCursor(false);
	end
end

function hoverButton_closeDown()
	guiSetProperty(source, "ImageColours", "tl:a2d26200 tr:a2d26200 bl:a2d26200 br:a2d26200");
end

function hoverButton_closeUp()
	guiSetProperty(source, "ImageColours", "tl:a2d26200 tr:a2d26200 bl:a2d26200 br:a2d26200");
end