local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1920), (screenH/1024) 

local custom_fonts = {
	regular = dxCreateFont('files/regular.ttf', 10)
}

local infobox = {}
local margin = 1

addEventHandler('onClientRender', root,
	function()
		for i, info in ipairs(infobox) do
			local previous = infobox[i - 1]
			if (i > 3) then 
				table.remove(infobox, 1)
			end

			if (getTickCount() - info.tick > 10 * 1000) then
				table.remove(infobox, 1)
			end

			local updateY = (isPedInVehicle(localPlayer) and 790 or 990)

			local posAct = {y = (y * (updateY - info.pos.h)), h = (y * (20 + info.pos.h))}
			if (previous) and (previous.posAct) then
				local prePosAct = previous.posAct
				posAct.y = prePosAct.y - posAct.h - margin
			end
			info.posAct = posAct

			local progress = interpolateBetween(0, 0, 0, 350, 0, 0, (getTickCount() - info.tick) / (6 * 1000), 'Linear')

			dxDrawRectangle(x * 23.0, posAct.y, x * 350, posAct.h, tocolor(info.color[1], info.color[2], info.color[3], info.alpha), true)
			dxDrawRectangle(x * 23.0, posAct.y, x * progress, posAct.h, tocolor(info.colorProgress[1], info.colorProgress[2], info.colorProgress[3], info.alpha), true)
			dxDrawText(info.message, x * 30, posAct.y + 4, x * 350, y * (517 + info.pos.h), tocolor(255, 255, 255, info.alpha), 1, custom_fonts.regular, 'left', 'top', false, true, true, false, false)

			if ((getTickCount() - info.tick) >= (10 * 1000) - 1000) then
				if (not info.fadeOutTick) then
					info.fadeOutTick = getTickCount()
				end
				local alpha = interpolateBetween(230, 0, 0, 0, 0, 0, (getTickCount() - info.fadeOutTick) / 1000, 'Linear')
				info.alpha = alpha
			end
		end
	end
)

function addBox(type, text)
	local textW, textH = dxGetTextSize(text, x * (269 - x * 85), 1, 1, custom_fonts.regular, true, false)
	local text = tostring(text)
	local sound = playSound ('files/bulle.wav', false)

	local self = setmetatable({
		message = text,
		dup = 1,
		color = {},
		colorProgress = {},
		pos = {
			x = textW,
			h = textH,
		},
		alpha = 230,
		tick = getTickCount(),
		style = type,
	}, infobox)

	for i, info in ipairs(infobox) do
		if (info.dup > 1) then
			if (info.message == text..' x'..tonumber(info.dup)) then
				table.remove(infobox, i)
				if (self) then
					self.tick = info.tick
					self.alpha = info.alpha
					self.dup = info.dup + 1
					self.message = text..' x'..tonumber(self.dup)
				end
			end
		else
			if (info.message == text) then
				table.remove(infobox, i)
				if (self) then
					self.tick = info.tick
					self.alpha = info.alpha
					self.dup = info.dup + 1
					self.message = text..' x'..tonumber(self.dup)
				end
			end
		end
	end

	if (self) then
		if (self.style == 'error') then
			self.color = {231, 94, 87}
			self.colorProgress = {236, 110, 101}
		elseif (self.style == 'success') then
			self.color = {143, 156, 81}
			self.colorProgress = {159, 169, 102}
		elseif (self.style == 'info') then
			self.color = { 204, 145, 255}
			self.colorProgress = {197, 130, 255}
		elseif (self.style == 'staff') then
			self.color = {179, 146, 4}
			self.colorProgress = {255, 208, 0}
		elseif (self.style == 'warning') then
			self.color = {67, 8, 121}
			self.colorProgress = {67, 40, 121}
		elseif (self.style == 'ptr') then
			self.color = {78, 144, 178}
			self.colorProgress = {99, 157, 181}
		elseif (self.style == 'jail') then
			self.color = {178, 34, 34}
			self.colorProgress = {178, 46, 34}
		elseif (self.style == 'kick') then
			self.color = {218, 147, 44}
			self.colorProgress = {218, 167, 44}
		elseif (self.style == 'ban') then
			self.color = {139, 28, 98}
			self.colorProgress = {139, 38, 98}
		end
		table.insert(infobox, self)
		outputConsole('['..type..'] '..text)
	end
	return self
end
addEvent('addBox', true)
addEventHandler('addBox', getRootElement(), addBox)