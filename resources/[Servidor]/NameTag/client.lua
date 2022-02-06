--// Ayarlar //--

tablo1 = {}
local uzaklik  = 70
local buyukluk = 1
local font = "default-bold"


function bar_olustur1(x, y, v, d)
if v < 0 then
v = 0
elseif v > 100 then
v = 100
end
dxDrawRectangle(x - 21, y, 42, 5, tocolor(18, 18, 18, 255 - d))
dxDrawRectangle(x - 20, y + 1, v / 2.5, 3, tocolor((100 - v) * 2.55, v * 2.55, 0, 255 - d))
end

function bar_olustur2(x, y, v, d)
if v < 0 then
v = 0
elseif v > 100 then
v = 100
end
dxDrawRectangle(x - 21, y, 42, 5, tocolor(18, 18, 18, 255 - d))
dxDrawRectangle(x - 20, y + 1, v / 2.5, 3, tocolor(255, 255, 255, 255 - d))
end

addEventHandler("onClientRender",root,function()


local cx, cy, cz, lx, ly, lz = getCameraMatrix()
local oyuncular = getElementsByType("player")
for k, oyuncu in pairs(tablo1) do
if isElement(oyuncu) and isElementStreamedIn(oyuncu) then do
local vx, vy, vz = getPedBonePosition(oyuncu, 8)
local yakinlas = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz)
if yakinlas < uzaklik and isLineOfSightClear(cx, cy, cz, vx, vy, vz, true, false, false) then
local x, y = getScreenFromWorldPosition(vx, vy, vz + 0.3)
if x and y then
		
local oyuncu_adi = getPlayerName(oyuncu)
local isim  = getPlayerName(oyuncu):gsub('#%x%x%x%x%x%x', '')
local yatay = dxGetTextWidth(isim, 1, font)
local dikey = dxGetFontHeight(1, font)
local tag = getElementData(oyuncu,"NameTag:Processo") or ""
shadowedText2(tag, x - 45 - yatay / 2, y - dikey - 35, yatay, dikey, tocolor(255,255,255,math.abs(math.sin(getTickCount()/999))*255),1,"default-bold")
shadowedText(oyuncu_adi, x - 4 - yatay / 2, y - dikey - 15, yatay, dikey, tocolor(getPlayerNametagColor(oyuncu)),1,"default-bold")

local can = getElementHealth(oyuncu)
local zirh = getPedArmor(oyuncu)
if can > 0 then
local sayi = 600 / getPedStat(oyuncu, 24)
bar_olustur1(x, y - 6, can * sayi, yakinlas)

if zirh > 0 then
bar_olustur2(x, y - 12, zirh, yakinlas)

end
end
end
end
end
else
table.remove(tablo1, k)
end
end
end)

--// Renk Kodlarını Gizle//--

function islev(text)
return string.gsub(text, "(#%x%x%x%x%x%x)", function(colorString)
return ""
end)
end

--// Renk Kodlarını Gizle //--

function dxDrawColorText(str, ax, ay, bx, by, color, scale, font)
local pat = "(.-)#(%x%x%x%x%x%x)"
local s, e, cap, col = str:find(pat, 1)
local last = 1
while s do
if cap == "" and col then
color = tocolor(tonumber("0x" .. col:sub(1, 2)), tonumber("0x" .. col:sub(3, 4)), tonumber("0x" .. col:sub(5, 6)),math.abs(math.sin(getTickCount()/999))*255)
end
if s ~= 1 or cap ~= "" then
local w = dxGetTextWidth(cap, scale, font)
dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
ax = ax + w
color = tocolor(tonumber("0x" .. col:sub(1, 2)), tonumber("0x" .. col:sub(3, 4)), tonumber("0x" .. col:sub(5, 6)),math.abs(math.sin(getTickCount()/999))*255)
end
last = e + 1
s, e, cap, col = str:find(pat, last)
end
if last <= #str then
cap = str:sub(last)
local w = dxGetTextWidth(cap, scale, font)
dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
end
end


--// Script Startlanınca Olacak İşlem //--
addEventHandler("onClientResourceStart",root,function(startedResource)
local oyuncular = getElementsByType("player")
for k, v in pairs(oyuncular) do
if isElementStreamedIn(v) and v ~= getLocalPlayer() then
setPlayerNametagShowing(v, false)
table.insert(tablo1, v)
end
end
end)

--// Orjinal Name Tagı Kapat //--
addEventHandler("onClientElementStreamIn",root,function()
if getElementType(source) == "player" and source ~= getLocalPlayer() then
setPlayerNametagShowing(source, false)
table.insert(tablo1,source)
end
end)

-- taslak --

function shadowedText2(text, left, top, right, bottom, ca, scale, font, alignX, alignY, clip, wordBreak,postGUI) 
	color = tocolor(0,0,0)
 	dxDrawText(RemoveHEXColorCode( text ),left+1,top+1,right,bottom,color,scale,font,alignX,alignY, false, false, false, true)
 	dxDrawText(RemoveHEXColorCode( text ),left-1,top+1,right,bottom,color,scale,font,alignX,alignY, false, false, false, true)
 	dxDrawText(RemoveHEXColorCode( text ),left+1,top-1,right,bottom,color,scale,font,alignX,alignY, false, false, false, true)
 	dxDrawText(RemoveHEXColorCode( text ),left-1,top-1,right,bottom,color,scale,font,alignX,alignY, false, false, false, true)
	dxDrawText(text,left,top,right,bottom,tocolor(255,255,255,math.abs(math.sin(getTickCount()/999))*255),scale,font,alignX,alignY, false, false, false, true)
end 

function shadowedText(text, left, top, right, bottom, ca, scale, font, alignX, alignY, clip, wordBreak,postGUI) 
	color = tocolor(0,0,0)
 	dxDrawText(RemoveHEXColorCode( text ),left+1,top+1,right,bottom,color,scale,font,alignX,alignY, false, false, false, true)
 	dxDrawText(RemoveHEXColorCode( text ),left-1,top+1,right,bottom,color,scale,font,alignX,alignY, false, false, false, true)
 	dxDrawText(RemoveHEXColorCode( text ),left+1,top-1,right,bottom,color,scale,font,alignX,alignY, false, false, false, true)
 	dxDrawText(RemoveHEXColorCode( text ),left-1,top-1,right,bottom,color,scale,font,alignX,alignY, false, false, false, true)
	dxDrawText(text,left,top,right,bottom,tocolor(255,255,255,255),scale,font,alignX,alignY, false, false, false, true)
end 

function RemoveHEXColorCode( s )
			return s:gsub( '#%x%x%x%x%x%x', '' ) or s
end


-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy