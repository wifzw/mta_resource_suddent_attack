--[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	gui\admin_main.lua
*
*	Original File by lil_Toady
*
*	Traduzido por #Flavio
*
**************************************]]

aAdminForm = nil
aLastCheck = 0
aCurrentVehicle = 411
aCurrentWeapon = 30
aCurrentAmmo = 1000
aCurrentSlap = 50
aPlayers = {}
aBans = {}
aLastSync = 0
aResources = {}

function unfuck(text)
  return string.gsub(text, "(#%x%x%x%x%x%x)", function(colorString)
   return ""
  end)
end

local name = unfuck(getPlayerName(localPlayer))

function aAdminMenu ()
	if ( aAdminForm == nil ) then
		local x, y = guiGetScreenSize()
		aAdminForm			= guiCreateWindow ( x / 2 - 310, y / 2 - 260, 750, 650, "", false )
		guiWindowSetSizable ( aAdminForm, false )
		guiSetText ( aAdminForm, "..:: Painel Admin Exclusivo v1.0 ::.. >> Administrador atual: "..name.." <<")
		
		
		infopanel = guiCreateLabel ( 0.725, 0.05, 0.45, 0.04, "Traduzido/Editado por", true, aAdminForm )
		infopanel2 = guiCreateLabel ( 0.901, 0.05, 0.45, 0.04, "#", true, aAdminForm )
		infopanel3 = guiCreateLabel ( 0.914, 0.05, 0.45, 0.04, "Flavio", true, aAdminForm )
				
		guiSetProperty(aAdminForm, "CaptionColour", "FF00ffff") 
		guiLabelSetColor ( infopanel, 255, 255, 255 )
		guiSetFont ( infopanel, "default-bold-small" )
		guiLabelSetColor ( infopanel2, 0, 255, 0 )
		guiSetFont ( infopanel2, "default-bold-small" )
		guiLabelSetColor ( infopanel3, 200, 200, 200 )
		guiSetFont ( infopanel3, "default-bold-small" )		
		
		aTabPanel			= guiCreateTabPanel ( 0.01, 0.05, 0.98, 0.95, true, aAdminForm )
		aTab1 = {}	
		aTab1.Tab			= guiCreateTab ( "Jogadores", aTabPanel, "players" )
				
		aTab1.Messages		= guiCreateButton ( 0.75, 0.02, 0.23, 0.04, "0/0 mensagens", true, aTab1.Tab )
		guiSetProperty(aTab1.Messages, "NormalTextColour", "FFFF0000")
		aTab1.ScreenShots		= guiCreateButton ( 0.75, 0.065, 0.23, 0.04, "Capturas de tela", true, aTab1.Tab )
		guiSetProperty(aTab1.ScreenShots, "NormalTextColour", "FF00FFBB")
		aTab1.PlayerListSearch 	= guiCreateEdit ( 0.03, 0.05, 0.16, 0.04, "", true, aTab1.Tab )
						  guiCreateStaticImage ( 0.19, 0.05, 0.035, 0.04, "client\\images\\search.png", true, aTab1.Tab )
		aTab1.HideColorCodes= guiCreateCheckBox ( 0.037, 0.94, 0.20, 0.04, "Ocultar códigos", true, true, aTab1.Tab )
		guiSetFont ( aTab1.HideColorCodes, "default-bold-small")
		guiSetProperty(aTab1.HideColorCodes, "NormalTextColour", "FFFF0000")
		aTab1.PlayerList		= guiCreateGridList ( 0.03, 0.10, 0.20, 0.83, true, aTab1.Tab )
		 guiSetFont (aTab1.PlayerList, "default-bold-small" )
						  guiGridListAddColumn( aTab1.PlayerList, "Jogadores", 0.85 )
						  for id, player in ipairs ( getElementsByType ( "player" ) ) do guiGridListSetItemPlayerName ( aTab1.PlayerList, guiGridListAddRow ( aTab1.PlayerList ), 1, getPlayerName ( player ), false, false ) end						  						  									  
		aTab1.Kick			= guiCreateButton ( 0.71, 0.125, 0.13, 0.04, "Expulsar", true, aTab1.Tab, "kick" )
		guiSetProperty(aTab1.Kick, "NormalTextColour", "FF00FFBB")
		aTab1.Ban			= guiCreateButton ( 0.85, 0.125, 0.13, 0.04, "Banir", true, aTab1.Tab, "ban" )
		guiSetProperty(aTab1.Ban, "NormalTextColour", "FF00FFBB")
		aTab1.Mute			= guiCreateButton ( 0.71, 0.170, 0.13, 0.04, "Mutar", true, aTab1.Tab, "mute" )
		guiSetProperty(aTab1.Mute, "NormalTextColour", "FF00FFBB")
		aTab1.Freeze		= guiCreateButton ( 0.85, 0.170, 0.13, 0.04, "Congelar", true, aTab1.Tab, "freeze" )
		guiSetProperty(aTab1.Freeze, "NormalTextColour", "FF00FFBB")
		aTab1.Spectate		= guiCreateButton ( 0.71, 0.215, 0.13, 0.04, "Ver jogador", true, aTab1.Tab, "spectate" )
		guiSetProperty(aTab1.Spectate, "NormalTextColour", "FF00FFBB")
		aTab1.Slap			= guiCreateButton ( 0.85, 0.215, 0.13, 0.04, "Slap! "..aCurrentSlap.." _", true, aTab1.Tab, "slap" )
		guiSetProperty(aTab1.Slap, "NormalTextColour", "FF00FFBB")
		aTab1.SlapDropDown	= guiCreateStaticImage ( 0.95, 0.215, 0.03, 0.04, "client\\images\\dropdown.png", true, aTab1.Tab )
		aTab1.SlapOptions		= guiCreateGridList ( 0.85, 0.215, 0.13, 0.40, true, aTab1.Tab )
						  guiGridListSetSortingEnabled ( aTab1.SlapOptions, false )
						  	guiSetFont (aTab1.SlapOptions, "default-bold-small" )
						  guiGridListAddColumn( aTab1.SlapOptions, "", 0.85 )
						  guiSetVisible ( aTab1.SlapOptions, false )
						  for i = 0, 10 do guiGridListSetItemText ( aTab1.SlapOptions, guiGridListAddRow ( aTab1.SlapOptions ), 1, tostring ( i * 10 ), false, false ) end
		aTab1.Nick			= guiCreateButton ( 0.71, 0.260, 0.13, 0.04, "Troca Nick", true, aTab1.Tab )
		guiSetProperty(aTab1.Nick, "NormalTextColour", "FF00FFBB")
		aTab1.Shout			= guiCreateButton ( 0.85, 0.260, 0.13, 0.04, "Advertência!", true, aTab1.Tab, "shout" )
		guiSetProperty(aTab1.Shout, "NormalTextColour", "FF00FFBB")
		aTab1.Admin			= guiCreateButton ( 0.71, 0.305, 0.27, 0.04, "Dar permissões", true, aTab1.Tab, "setgroup" )
	    guiSetProperty(aTab1.Admin, "NormalTextColour", "FF00FFBB")
		local y = 0.03		-- Start y coord
		local A = 0.045		-- Large line gap
		local B = 0.035		-- Small line gap

						     guiCreateHeader ( 0.25, 0.042, 0.20, 0.04, "Jogador:", true, aTab1.Tab )
							 
							--Nomepainel = guiCreateLabel ( 0.35, 0.040, 0.60, 0.035, "* Administrador atual "..name.."  :D", true, aTab1.Tab )
							--guiLabelSetColor ( Nomepainel, 255, 255, 255 )
	                    --	guiSetFont ( Nomepainel, "default-bold-small" )
							 
y=y+A   aTab1.Name			= guiCreateLabel ( 0.26, y, 0.30, 0.035, "Nome: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Name, 0, 255, 255 )
		guiSetFont ( aTab1.Name, "default-bold-small" )
y=y+A   aTab1.IP			= guiCreateLabel ( 0.26, y, 0.30, 0.035, "IP: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.IP, 0, 255, 255 )
		guiSetFont ( aTab1.IP, "default-bold-small" )
		aTab1.CountryCode	= guiCreateLabel ( 0.45, y, 0.04, 0.035, "", true, aTab1.Tab )
		aTab1.Flag	  = guiCreateStaticImage ( 0.40, y, 0.025806, 0.021154, "client\\images\\empty.png", true, aTab1.Tab )
y=y+A   aTab1.Serial		= guiCreateLabel ( 0.26, y, 0.435, 0.035, "Serial: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Serial, 0, 255, 255 )
		guiSetFont ( aTab1.Serial, "default-bold-small" )
		--aTab1.Username		= guiCreateLabel ( 0.26, 0.245, 0.435, 0.035, "Username: N/A", true, aTab1.Tab )
y=y+B   aTab1.Version		= guiCreateLabel ( 0.26, y, 0.435, 0.035, "Versão: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Version, 0, 255, 255 )
		guiSetFont ( aTab1.Version, "default-bold-small" )
y=y+B   aTab1.Accountname	= guiCreateLabel ( 0.26, y, 0.435, 0.035, "Usuario: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Accountname, 0, 255, 255 )
		guiSetFont ( aTab1.Accountname, "default-bold-small" )
y=y+B   aTab1.Groups		= guiCreateLabel ( 0.26, y, 0.435, 0.035, "Equipe: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Groups, 0, 255, 255 )
		guiSetFont ( aTab1.Groups, "default-bold-small" )
y=y+A   aTab1.ACDetected	= guiCreateLabel ( 0.26, y, 0.30, 0.035, "AC Detected: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.ACDetected, 0, 255, 255 )
		guiSetFont ( aTab1.ACDetected, "default-bold-small" )
y=y+B   aTab1.ACD3D			= guiCreateLabel ( 0.26, y, 0.30, 0.035, "D3D9.DLL: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.ACD3D, 0, 255, 255 )
		guiSetFont ( aTab1.ACD3D, "default-bold-small" )
y=y+B   aTab1.ACModInfo		= guiCreateLabel ( 0.26, y, 0.20, 0.035, "Img Mods: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.ACModInfo, 0, 255, 255 )
		guiSetFont ( aTab1.ACModInfo, "default-bold-small" )
		aTab1.ACModDetails = guiCreateButton ( 0.46, y, 0.13, 0.04, "Detalhes", true, aTab1.Tab )
        guiSetProperty(aTab1.ACModDetails, "NormalTextColour", "FF00FFBB")


y=y+A  				         guiCreateHeader ( 0.25, y, 0.20, 0.04, "Status:", true, aTab1.Tab )
y=y+A   aTab1.Health		= guiCreateLabel ( 0.26, y, 0.20, 0.04, "Vida: 0%", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Health, 0, 255, 255 )
		guiSetFont ( aTab1.Health, "default-bold-small" )
		aTab1.Armour		= guiCreateLabel ( 0.45, y, 0.20, 0.04, "Colete: 0%", true, aTab1.Tab )
				guiLabelSetColor ( aTab1.Armour, 0, 255, 255 )
		guiSetFont ( aTab1.Armour, "default-bold-small" )
y=y+B   aTab1.Skin			= guiCreateLabel ( 0.26, y, 0.20, 0.04, "Skin: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Skin, 0, 255, 255 )
		guiSetFont ( aTab1.Skin, "default-bold-small" )
		aTab1.Team			= guiCreateLabel ( 0.45, y, 0.20, 0.04, "Equipe: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Team, 0, 255, 255 )
		guiSetFont ( aTab1.Team, "default-bold-small" )
y=y+B   aTab1.Weapon		= guiCreateLabel ( 0.26, y, 0.35, 0.04, "Arma: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Weapon, 0, 255, 255 )
		guiSetFont ( aTab1.Weapon, "default-bold-small" )
y=y+B   aTab1.Ping			= guiCreateLabel ( 0.26, y, 0.20, 0.04, "Ping: 0", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Ping, 0, 255, 255 )
		guiSetFont ( aTab1.Ping, "default-bold-small" )
		aTab1.Money			= guiCreateLabel ( 0.45, y, 0.20, 0.04, "Dinheiro: 0", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Money, 0, 255, 255 )
		guiSetFont ( aTab1.Money, "default-bold-small" )
y=y+B   aTab1.Area			= guiCreateLabel ( 0.26, y, 0.44, 0.04, "Area: Desconhecida", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Area, 0, 255, 255 )
		guiSetFont ( aTab1.Area, "default-bold-small" )
y=y+B   aTab1.PositionX		= guiCreateLabel ( 0.26, y, 0.30, 0.04, "X: 0", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.PositionX, 0, 255, 255 )
		guiSetFont ( aTab1.PositionX, "default-bold-small" )
y=y+B   aTab1.PositionY		= guiCreateLabel ( 0.26, y, 0.30, 0.04, "Y: 0", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.PositionY, 0, 255, 255 )
		guiSetFont ( aTab1.PositionY, "default-bold-small")
y=y+B   aTab1.PositionZ		= guiCreateLabel ( 0.26, y, 0.30, 0.04, "Z: 0", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.PositionZ, 0, 255, 255 )
		guiSetFont ( aTab1.PositionZ, "default-bold-small")
y=y+B   aTab1.Dimension		= guiCreateLabel ( 0.26, y, 0.20, 0.04, "Dimensão: 0", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Dimension, 0, 255, 255 )
		guiSetFont ( aTab1.Dimension, "default-bold-small")
		aTab1.Interior		= guiCreateLabel ( 0.45, y, 0.20, 0.04, "Interior: 0", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Interior, 0, 255, 255 )
		guiSetFont ( aTab1.Interior, "default-bold-small")

y=y+A  				         guiCreateHeader ( 0.25, y, 0.878, 0.04, "Veiculo:", true, aTab1.Tab )
y=y+A  aTab1.Vehicle		= guiCreateLabel ( 0.26, 0.840, 0.878, 0.04, "Veiculo: N/A", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.Vehicle, 0, 255, 255 )
		guiSetFont ( aTab1.Vehicle, "default-bold-small")
y=y+B  aTab1.VehicleHealth	= guiCreateLabel ( 0.26, 0.875, 0.25, 0.04, "Dano no veiculo: 0%", true, aTab1.Tab )
		guiLabelSetColor ( aTab1.VehicleHealth, 0, 255, 255 )
		guiSetFont ( aTab1.VehicleHealth, "default-bold-small")

		aTab1.SetHealth		= guiCreateButton ( 0.71, 0.395, 0.13, 0.04, "Vida", true, aTab1.Tab, "sethealth" )
		guiSetProperty(aTab1.SetHealth		, "NormalTextColour", "FF00FFBB")
		aTab1.SetArmour		= guiCreateButton ( 0.85, 0.395, 0.13, 0.04, "Colete", true, aTab1.Tab, "setarmour" )
		guiSetProperty(aTab1.SetArmour, "NormalTextColour", "FF00FFBB")
		aTab1.SetSkin		= guiCreateButton ( 0.71, 0.440, 0.13, 0.04, "Skin", true, aTab1.Tab, "setskin" )
		guiSetProperty(aTab1.SetSkin, "NormalTextColour", "FF00FFBB")
		aTab1.SetTeam		= guiCreateButton ( 0.85, 0.440, 0.13, 0.04, "Equipe", true, aTab1.Tab, "setteam" )
		guiSetProperty(aTab1.SetTeam, "NormalTextColour", "FF00FFBB")		
		aTab1.SetDimension	= guiCreateButton ( 0.71, 0.755, 0.13, 0.04, "Dimensão", true, aTab1.Tab, "setdimension" )
		guiSetProperty(aTab1.SetDimension, "NormalTextColour", "FF00FFBB")	
		aTab1.SetInterior		= guiCreateButton ( 0.85, 0.755, 0.13, 0.04, "Interior", true, aTab1.Tab, "setinterior" )
		guiSetProperty(aTab1.SetInterior, "NormalTextColour", "FF00FFBB")	
		aTab1.GiveWeapon		= guiCreateButton ( 0.71, 0.485, 0.27, 0.04, "Dar: "..getWeaponNameFromID ( aCurrentWeapon ), true, aTab1.Tab, "giveweapon" )
		guiSetProperty(aTab1.GiveWeapon, "NormalTextColour", "FF00FFBB")	
		aTab1.WeaponDropDown	= guiCreateStaticImage ( 0.95, 0.485, 0.03, 0.04, "client\\images\\dropdown.png", true, aTab1.Tab )
		aTab1.WeaponOptions	= guiCreateGridList ( 0.71, 0.485, 0.27, 0.48, true, aTab1.Tab )	
		guiSetFont (aTab1.WeaponOptions, "default-bold-small" )
		
						  guiGridListAddColumn( aTab1.WeaponOptions, "", 0.85 )
						  guiSetVisible ( aTab1.WeaponOptions, false )
						  for i = 1, 46 do if ( getWeaponNameFromID ( i ) ~= false ) then guiGridListSetItemText ( aTab1.WeaponOptions, guiGridListAddRow ( aTab1.WeaponOptions ), 1, getWeaponNameFromID ( i ), false, false ) end end
		aTab1.SetMoney		= guiCreateButton ( 0.71, 0.530, 0.13, 0.04, "Dinheiro", true, aTab1.Tab, "setmoney" )
		guiSetProperty(aTab1.SetMoney, "NormalTextColour", "FF00FFBB")
		aTab1.SetStats		= guiCreateButton ( 0.85, 0.530, 0.13, 0.04, "Status", true, aTab1.Tab, "setstat" )
		guiSetProperty(aTab1.SetStats, "NormalTextColour", "FF00FFBB")		
		aTab1.JetPack		= guiCreateButton ( 0.71, 0.575, 0.27, 0.04, "JetPack", true, aTab1.Tab, "jetpack" )
		guiSetProperty(aTab1.JetPack, "NormalTextColour", "FF00FFBB")		
		aTab1.Warp			= guiCreateButton ( 0.71, 0.620, 0.27, 0.04, "Ir para jogador...", true, aTab1.Tab, "warp" )
		guiSetProperty(aTab1.Warp, "NormalTextColour", "FF00FFBB")		
		aTab1.WarpTo		= guiCreateButton ( 0.71, 0.665, 0.27, 0.04, "Teleporta jogador para..", true, aTab1.Tab, "warp" )
			guiSetProperty(aTab1.WarpTo, "NormalTextColour", "FF00FFBB")	
		aTab1.VehicleFix		= guiCreateButton ( 0.71, 0.84, 0.13, 0.04, "Reparar", true, aTab1.Tab, "repair" )
			guiSetProperty(aTab1.VehicleFix, "NormalTextColour", "FF00FFBB")	
		aTab1.VehicleDestroy	= guiCreateButton ( 0.71, 0.89, 0.13, 0.04, "Destruir", true, aTab1.Tab, "destroyvehicle" )
			guiSetProperty(aTab1.VehicleDestroy, "NormalTextColour", "FF00FFBB")	
		aTab1.VehicleBlow		= guiCreateButton ( 0.85, 0.84, 0.13, 0.04, "Explodir", true, aTab1.Tab, "blowvehicle" )
			guiSetProperty(aTab1.VehicleBlow, "NormalTextColour", "FF00FFBB")	
		aTab1.VehicleCustomize 	= guiCreateButton ( 0.85, 0.89, 0.13, 0.04, "Customizar", true, aTab1.Tab, "customize" )
			guiSetProperty(aTab1.VehicleCustomize, "NormalTextColour", "FF00FFBB")	
		aTab1.AnonAdmin		  = guiCreateCheckBox (0.855, 0.942, 0.20, 0.04, "Anonymous", isAnonAdmin(), true, aTab1.Tab )
		guiSetFont ( aTab1.AnonAdmin, "default-bold-small" )
		guiSetProperty(aTab1.AnonAdmin, "NormalTextColour", "FFFF0000")
		aTab1.GiveVehicle		= guiCreateButton ( 0.71, 0.710, 0.27, 0.04, "Dar: "..getVehicleNameFromModel ( aCurrentVehicle ), true, aTab1.Tab, "givevehicle" )
		guiSetProperty(aTab1.GiveVehicle, "NormalTextColour", "FF00FFBB")
		aTab1.VehicleDropDown 	= guiCreateStaticImage ( 0.95, 0.710, 0.03, 0.04, "client\\images\\dropdown.png", true, aTab1.Tab )
		local gx, gy 		= guiGetSize ( aTab1.GiveVehicle, false )
		aTab1.VehicleOptions	= guiCreateGridList ( 0, 0, gx, 200, false )
						  guiGridListAddColumn( aTab1.VehicleOptions, "", 0.85 )
						  guiSetFont (aTab1.VehicleOptions, "default-bold-small" )
						  guiSetAlpha ( aTab1.VehicleOptions, 0.80 )
						  guiSetVisible ( aTab1.VehicleOptions, false )
							local vehicleNames = {}
							for i = 400, 611 do
								if ( getVehicleNameFromModel ( i ) ~= "" ) then
									table.insert( vehicleNames, { model = i, name = getVehicleNameFromModel ( i ) } )
								end
							end
							table.sort( vehicleNames, function(a, b) return a.name < b.name end )
							for _,info in ipairs(vehicleNames) do
								local row = guiGridListAddRow ( aTab1.VehicleOptions )
								guiGridListSetItemText ( aTab1.VehicleOptions, row, 1, info.name, false, false )
								guiGridListSetItemData ( aTab1.VehicleOptions, row, 1, tostring ( info.model ) )
							end
		aTab2 = {}
		aTab2.Tab			= guiCreateTab ( "Recursos", aTabPanel, "resources" )
		aTab2.ManageACL		= guiCreateButton ( 0.75, 0.02, 0.23, 0.04, "Gerenciar ACL", true, aTab2.Tab )
		guiSetProperty(aTab2.ManageACL, "NormalTextColour", "FFFF0000")	
		aTab2.ResourceListSearch = guiCreateEdit ( 0.03, 0.05, 0.31, 0.04, "", true, aTab2.Tab )
						  guiCreateStaticImage ( 0.34, 0.05, 0.035, 0.04, "client\\images\\search.png", true, aTab2.Tab )
		aTab2.ResourceList	= guiCreateGridList ( 0.03, 0.10, 0.35, 0.80, true, aTab2.Tab )
						  guiGridListAddColumn( aTab2.ResourceList, "Recurso", 0.55 )
						  guiGridListAddColumn( aTab2.ResourceList, "", 0.05 )
						  guiGridListAddColumn( aTab2.ResourceList, "Estado", 0.35 )
						  guiGridListAddColumn( aTab2.ResourceList, "Nome", 0.6 )
						  guiGridListAddColumn( aTab2.ResourceList, "Autor", 0.4 )
						  guiGridListAddColumn( aTab2.ResourceList, "Versao", 0.2 )
		aTab2.ResourceInclMaps	= guiCreateCheckBox ( 0.03, 0.91, 0.15, 0.04, "Ver Mapas...", false, true, aTab2.Tab )
		guiSetFont ( aTab2.ResourceInclMaps, "default-bold-small" )
		guiSetProperty(aTab2.ResourceInclMaps, "NormalTextColour", "FF00FFFF")
		aTab2.ResourceRefresh	= guiCreateButton ( 0.20, 0.915, 0.18, 0.04, "Atualizar...", true, aTab2.Tab, "listresources" )
		guiSetProperty(aTab2.ResourceRefresh, "NormalTextColour", "FF00FFBB")	
		aTab2.ResourceSettings	= guiCreateButton ( 0.40, 0.05, 0.20, 0.04, "Configurações", true, aTab2.Tab )
				guiSetProperty(aTab2.ResourceSettings, "NormalTextColour", "FF00FFBB")	
		aTab2.ResourceStart	= guiCreateButton ( 0.40, 0.10, 0.20, 0.04, "Iniciar", true, aTab2.Tab, "start" )
				guiSetProperty(aTab2.ResourceStart, "NormalTextColour", "FF00FFBB")	
		aTab2.ResourceRestart	= guiCreateButton ( 0.40, 0.15, 0.20, 0.04, "Reiniciar", true, aTab2.Tab, "restart" )
				guiSetProperty(aTab2.ResourceRestart, "NormalTextColour", "FF00FFBB")	
		aTab2.ResourceStop	= guiCreateButton ( 0.40, 0.20, 0.20, 0.04, "Parar", true, aTab2.Tab, "stop" )
				guiSetProperty(aTab2.ResourceStop, "NormalTextColour", "FF00FFBB")	
		aTab2.ResourceDelete	= guiCreateButton ( 0.40, 0.25, 0.20, 0.04, "Deletar", true, aTab2.Tab, "delete" )
		guiSetProperty(aTab2.ResourceDelete, "NormalTextColour", "FF00FFBB")
		aTab2.ResourcesStopAll	= guiCreateButton ( 0.63, 0.2, 0.20, 0.04, "Desligar tudo", true, aTab2.Tab, "stopall" )
		guiSetProperty(aTab2.ResourcesStopAll, "NormalTextColour", "FFFF0000")
		aTab2.ResourceFailture	= guiCreateButton ( 0.63, 0.10, 0.25, 0.04, "Get Load Failture", true, aTab2.Tab )
						 guiSetVisible ( aTab2.ResourceFailture, false )
		--aModules			= guiCreateTabPanel ( 0.40, 0.25, 0.57, 0.38, true, aTab2.Tab ) --What's that for?
							guiCreateHeader(0.40, 0.3, 0.3, 0.04, "Informações:", true, aTab2.Tab)
		aTab2.ResourceName			= guiCreateLabel ( 0.41, 0.35, 0.6, 0.03, "Nome: ", true, aTab2.Tab )
				guiLabelSetColor ( aTab2.ResourceName, 0, 255, 255 )
		guiSetFont ( aTab2.ResourceName, "default-bold-small" )
		aTab2.ResourceAuthor		= guiCreateLabel ( 0.41, 0.4, 0.6, 0.03, "Autor: ", true, aTab2.Tab )
				guiLabelSetColor ( aTab2.ResourceAuthor, 0, 255, 255 )
		guiSetFont ( aTab2.ResourceAuthor, "default-bold-small" )
		aTab2.ResourceVersion		= guiCreateLabel ( 0.41, 0.45, 0.6, 0.03, "Versão: ", true, aTab2.Tab )
				guiLabelSetColor ( aTab2.ResourceVersion, 0, 255, 255 )
		guiSetFont ( aTab2.ResourceVersion, "default-bold-small" )
					acoeslog =	  guiCreateLabel ( 0.40, 0.77, 0.20, 0.03, "Log dos recursos:", true, aTab2.Tab )
						  guiSetFont ( acoeslog, "default-bold-small" )
						  guiLabelSetColor ( acoeslog, 255, 0, 0 )
		aTab2.LogLine1		= guiCreateLabel ( 0.41, 0.81, 0.50, 0.03, "", true, aTab2.Tab )
		guiSetFont ( aTab2.LogLine1, "default-bold-small" )
		aTab2.LogLine2		= guiCreateLabel ( 0.41, 0.84, 0.50, 0.03, "", true, aTab2.Tab )
		guiSetFont ( aTab2.LogLine2, "default-bold-small" )
		aTab2.LogLine3		= guiCreateLabel ( 0.41, 0.87, 0.50, 0.03, "", true, aTab2.Tab )
		guiSetFont ( aTab2.LogLine3, "default-bold-small" )
		aTab2.LogLine4		= guiCreateLabel ( 0.41, 0.90, 0.50, 0.03, "", true, aTab2.Tab )
		guiSetFont ( aTab2.LogLine4, "default-bold-small" )
		aTab2.LogLine5		= guiCreateLabel ( 0.41, 0.93, 0.50, 0.03, "", true, aTab2.Tab )
		guiSetFont ( aTab2.LogLine5, "default-bold-small" )
				commands =		  guiCreateLabel ( 0.40, 0.65, 0.50, 0.04, "Console de comandos:", true, aTab2.Tab )
						  						  guiSetFont ( commands, "default-bold-small" )
						  guiLabelSetColor ( commands, 255, 255, 255 )
		aTab2.Command		= guiCreateEdit ( 0.41, 0.70, 0.40, 0.055, "", true, aTab2.Tab )
		aTab2.ExecuteClient	= guiCreateButton ( 0.82, 0.70, 0.16, 0.035, "Cliente", true, aTab2.Tab, "execute" )
					guiSetProperty(aTab2.ExecuteClient, "NormalTextColour", "FF00FFBB")		
		aTab2.ExecuteServer	= guiCreateButton ( 0.82, 0.736, 0.16, 0.035, "Servidor", true, aTab2.Tab, "execute" )
					guiSetProperty(aTab2.ExecuteServer, "NormalTextColour", "FF00FFBB")		
		aTab2.ExecuteAdvanced	= guiCreateLabel ( 0.45, 0.71, 0.50, 0.04, "Apenas para usuarios avançados.", true, aTab2.Tab )
						  guiLabelSetColor ( aTab2.ExecuteAdvanced, 255, 0, 0 )
						  guiSetFont ( aTab2.ExecuteAdvanced, "default-bold-small" )
		aLogLines = 1

		createMapTab()
		
		aTab3 = {}
		aTab3.Tab			= guiCreateTab ( "Servidor", aTabPanel, "server" )
		aTab3.Server		= guiCreateLabel ( 0.05, 0.05, 0.70, 0.05, "Servidor: N/A", true, aTab3.Tab )
						guiLabelSetColor ( aTab3.Server, 0, 255, 255 )
		guiSetFont ( aTab3.Server, "default-bold-small" )
		aTab3.Password		= guiCreateLabel ( 0.05, 0.10, 0.40, 0.05, "Password: N/A", true, aTab3.Tab )
		guiLabelSetColor ( aTab3.Password, 0, 255, 255 )
		guiSetFont ( aTab3.Password, "default-bold-small" )
		aTab3.GameType		= guiCreateLabel ( 0.05, 0.15, 0.40, 0.05, "Tipo de jogo: N/A", true, aTab3.Tab )
		guiLabelSetColor ( aTab3.GameType, 0, 255, 255 )
		guiSetFont ( aTab3.GameType, "default-bold-small" )
		aTab3.MapName		= guiCreateLabel ( 0.05, 0.20, 0.40, 0.05, "Nome do mapa: N/A", true, aTab3.Tab )
        guiLabelSetColor ( aTab3.MapName, 0, 255, 255 )
		guiSetFont ( aTab3.MapName, "default-bold-small" )
		aTab3.Players		= guiCreateLabel ( 0.05, 0.25, 0.20, 0.05, "Jogadores: 0/0", true, aTab3.Tab )
		guiLabelSetColor ( aTab3.Players, 0, 255, 255 )
		guiSetFont ( aTab3.Players, "default-bold-small" )	
		
		
		aTab3.SetPassword		= guiCreateButton ( 0.80, 0.05, 0.18, 0.04, "Senha", true, aTab3.Tab, "setpassword" )
		guiSetProperty(aTab3.SetPassword, "NormalTextColour", "FF00FFBB")	
		aTab3.ResetPassword	= guiCreateButton ( 0.80, 0.10, 0.18, 0.04, "Remover senha", true, aTab3.Tab, "setpassword" )
		guiSetProperty(aTab3.ResetPassword, "NormalTextColour", "FF00FFBB")	
		aTab3.SetGameType		= guiCreateButton ( 0.80, 0.15, 0.18, 0.04, "Modo de jogo", true, aTab3.Tab, "setgame" )
		guiSetProperty(aTab3.SetGameType, "NormalTextColour", "FF00FFBB")	
		aTab3.SetMapName		= guiCreateButton ( 0.80, 0.20, 0.18, 0.04, "Nome do mapa", true, aTab3.Tab, "setmap" )
		guiSetProperty(aTab3.SetMapName, "NormalTextColour", "FF00FFBB")	
		aTab3.SetWelcome		= guiCreateButton ( 0.80, 0.25, 0.18, 0.04, "Msg Boas vindas", true, aTab3.Tab, "setwelcome" )
		guiSetProperty(aTab3.SetWelcome, "NormalTextColour", "FF00FFBB")	
		aTab3.Shutdown		= guiCreateButton ( 0.80, 0.3, 0.18, 0.04, "Desligar", true, aTab3.Tab, "shutdown" )
		guiSetProperty(aTab3.Shutdown, "NormalTextColour", "FFFF0000")	
		
						  guiCreateStaticImage ( 0.05, 0.32, 0.73, 0.0025, "client\\images\\dot.png", true, aTab3.Tab )
		aTab3.WeatherCurrent	= guiCreateLabel ( 0.05, 0.35, 0.45, 0.05, "Current Weather: "..getWeather().." ("..getWeatherNameFromID ( getWeather() )..")", true, aTab3.Tab )
		aTab3.WeatherDec		= guiCreateButton ( 0.05, 0.40, 0.035, 0.04, "<", true, aTab3.Tab )
						guiSetProperty(aTab3.WeatherCurrent, "NormalTextColour", "FF00FFFF")
								guiLabelSetColor ( aTab3.WeatherCurrent, 0, 255, 255 )
		                        guiSetFont ( aTab3.WeatherCurrent, "default-bold-small" )	
		aTab3.Weather		= guiCreateEdit ( 0.095, 0.40, 0.35, 0.04, getWeather().." ("..getWeatherNameFromID ( getWeather() )..")", true, aTab3.Tab )
		guiSetFont ( aTab3.Weather, "default-bold-small" )
		aTab3.WeatherInc		= guiCreateButton ( 0.45, 0.40, 0.035, 0.04, ">", true, aTab3.Tab )
				guiSetProperty(aTab3.WeatherInc, "NormalTextColour", "FF00FFFF")	
						  guiEditSetReadOnly ( aTab3.Weather, true )
		aTab3.WeatherSet		= guiCreateButton ( 0.50, 0.40, 0.10, 0.04, "Aplicar", true, aTab3.Tab, "setweather" )
		guiSetProperty(aTab3.WeatherSet, "NormalTextColour", "FFFFFFFF")	
		aTab3.WeatherBlend	= guiCreateButton ( 0.61, 0.40, 0.15, 0.04, "Aleatório", true, aTab3.Tab, "blendweather" )
		guiSetProperty(aTab3.WeatherBlend, "NormalTextColour", "FF00FFFF")	

						  local th, tm = getTime()
		aTab3.TimeCurrent		= guiCreateLabel ( 0.05, 0.45, 0.25, 0.04, "Tempo: "..th..":"..tm, true, aTab3.Tab )
			guiLabelSetColor ( aTab3.TimeCurrent, 0, 255, 255 )
		    guiSetFont ( aTab3.TimeCurrent, "default-bold-small" )
		aTab3.TimeH			= guiCreateEdit ( 0.35, 0.45, 0.055, 0.04, "12", true, aTab3.Tab )
		guiSetFont ( aTab3.TimeH, "default-bold-small" )
		aTab3.TimeM			= guiCreateEdit ( 0.425, 0.45, 0.055, 0.04, "00", true, aTab3.Tab )
		guiSetFont ( aTab3.TimeM, "default-bold-small" )
						  guiCreateLabel ( 0.415, 0.45, 0.05, 0.04, ":", true, aTab3.Tab )
						  guiEditSetMaxLength ( aTab3.TimeH, 2 )
						  guiEditSetMaxLength ( aTab3.TimeM, 2 )
		aTab3.TimeSet		= guiCreateButton ( 0.50, 0.45, 0.10, 0.04, "Aplicar", true, aTab3.Tab, "settime" )
						  guiCreateLabel ( 0.63, 0.45, 0.12, 0.04, "( 0-23:0-59 )", true, aTab3.Tab )
		guiSetProperty(aTab3.TimeSet, "NormalTextColour", "FFFFFFFF")				  

		aTab3.GravityCurrent	= guiCreateLabel ( 0.05, 0.50, 0.28, 0.04, "Gravidade: "..string.sub ( getGravity(), 0, 6 ), true, aTab3.Tab )
					guiLabelSetColor ( aTab3.GravityCurrent, 0, 255, 255 )
		    guiSetFont ( aTab3.GravityCurrent, "default-bold-small" )
		aTab3.Gravity		= guiCreateEdit ( 0.35, 0.50, 0.135, 0.04, "0.008", true, aTab3.Tab )
		guiSetFont ( aTab3.Gravity, "default-bold-small" )
		aTab3.GravitySet		= guiCreateButton ( 0.50, 0.50, 0.10, 0.04, "Aplicar", true, aTab3.Tab, "setgravity" )
		guiSetProperty(aTab3.GravitySet, "NormalTextColour", "FFFFFFFF")

		aTab3.SpeedCurrent	= guiCreateLabel ( 0.05, 0.55, 0.30, 0.04, "Velocidade do jogo: "..getGameSpeed(), true, aTab3.Tab )
	    guiLabelSetColor ( aTab3.SpeedCurrent, 0, 255, 255 )
		guiSetFont ( aTab3.SpeedCurrent, "default-bold-small" )
		aTab3.Speed			= guiCreateEdit ( 0.35, 0.55, 0.135, 0.04, "1", true, aTab3.Tab )
		guiSetFont ( aTab3.Speed, "default-bold-small" )
		aTab3.SpeedSet		= guiCreateButton ( 0.50, 0.55, 0.10, 0.04, "Aplicar", true, aTab3.Tab, "setgamespeed" )
						  guiCreateLabel ( 0.63, 0.55, 0.09, 0.04, "( 0-10 )", true, aTab3.Tab )
		guiSetProperty(aTab3.SpeedSet, "NormalTextColour", "FFFFFFFF")					  

		aTab3.WavesCurrent	= guiCreateLabel ( 0.05, 0.60, 0.25, 0.04, "Altura das ondas: "..getWaveHeight(), true, aTab3.Tab )
	    guiLabelSetColor ( aTab3.WavesCurrent, 0, 255, 255 )
		guiSetFont ( aTab3.WavesCurrent, "default-bold-small" )		
		aTab3.Waves			= guiCreateEdit ( 0.35, 0.60, 0.135, 0.04, "0", true, aTab3.Tab )
		guiSetFont ( aTab3.Waves, "default-bold-small" )
		aTab3.WavesSet		= guiCreateButton ( 0.50, 0.60, 0.10, 0.04, "Aplicar", true, aTab3.Tab, "setwaveheight" )
					 	 guiCreateLabel ( 0.63, 0.60, 0.09, 0.04, "( 0-100 )", true, aTab3.Tab )
		guiSetProperty(aTab3.WavesSet, "NormalTextColour", "FFFFFFFF")					 
		
		aTab3.FPSCurrent	= guiCreateLabel ( 0.05, 0.65, 0.25, 0.04, "Limitar FPS: 38", true, aTab3.Tab )
	    guiLabelSetColor ( aTab3.FPSCurrent, 0, 255, 255 )
		guiSetFont ( aTab3.FPSCurrent, "default-bold-small" )	
		aTab3.FPS			= guiCreateEdit ( 0.35, 0.65, 0.135, 0.04, "38", true, aTab3.Tab )
		guiSetFont ( aTab3.FPS, "default-bold-small" )
		aTab3.FPSSet		= guiCreateButton ( 0.50, 0.65, 0.10, 0.04, "Aplicar", true, aTab3.Tab, "setfpslimit" )
					 	 guiCreateLabel ( 0.63, 0.65, 0.1, 0.04, "( 25-100 )", true, aTab3.Tab )
		guiSetProperty(aTab3.FPSSet, "NormalTextColour", "FFFFFFFF")					 
					 	 

		aTab4 = {}
		aTab4.Tab			= guiCreateTab ( "Bans", aTabPanel, "bans" )
		aTab4.BansList		= guiCreateGridList ( 0.03, 0.05, 0.80, 0.87, true, aTab4.Tab )
						  guiGridListAddColumn( aTab4.BansList, "Nome", 0.22 )
						  guiGridListAddColumn( aTab4.BansList, "IP", 0.22 )
						  guiGridListAddColumn( aTab4.BansList, "Serial", 0.22 )
						  guiGridListAddColumn( aTab4.BansList, "Banido por", 0.22 )
						  guiGridListAddColumn( aTab4.BansList, "Data", 0.17 )
						  guiGridListAddColumn( aTab4.BansList, "Tempo", 0.13 )
						  guiGridListAddColumn( aTab4.BansList, "Motivo", 0.92 )
						  guiGridListSetSortingEnabled( aTab4.BansList, false )
		aTab4.Details		= guiCreateButton ( 0.85, 0.10, 0.13, 0.04, "Detalhes", true, aTab4.Tab )
		guiSetProperty(aTab4.Details, "NormalTextColour", "FF00FFBB")	
		aTab4.Unban			= guiCreateButton ( 0.85, 0.20, 0.13, 0.04, "Desbanir", true, aTab4.Tab, "unban" )
		guiSetProperty(aTab4.Unban, "NormalTextColour", "FF00FFBB")
		aTab4.UnbanIP		= guiCreateButton ( 0.85, 0.25, 0.13, 0.04, "Desbanir IP", true, aTab4.Tab, "unbanip" )
		guiSetProperty(aTab4.UnbanIP, "NormalTextColour", "FF00FFBB")
		aTab4.UnbanSerial		= guiCreateButton ( 0.85, 0.30, 0.13, 0.04, "Desb.Serial", true, aTab4.Tab, "unbanserial" )
		guiSetProperty(aTab4.UnbanSerial, "NormalTextColour", "FF00FFBB")
		aTab4.BanIP			= guiCreateButton ( 0.85, 0.40, 0.13, 0.04, "Banir IP", true, aTab4.Tab, "banip" )
		guiSetProperty(aTab4.BanIP, "NormalTextColour", "FF00FFBB")
		aTab4.BanSerial		= guiCreateButton ( 0.85, 0.45, 0.13, 0.04, "Banir Serial", true, aTab4.Tab, "banserial" )
		guiSetProperty(aTab4.BanSerial, "NormalTextColour", "FF00FFBB") 
		aTab4.BansRefresh		= guiCreateButton ( 0.85, 0.85, 0.13, 0.04, "Atualizar...", true, aTab4.Tab, "listbans" )
		guiSetProperty(aTab4.BansRefresh, "NormalTextColour", "FF00FFBB")

		aTab4.BansTotal		= guiCreateLabel ( 0.20, 0.94, 0.31, 0.04, "Mostrando  0 / 0  bans", true, aTab4.Tab )
		guiLabelSetColor ( aTab4.BansTotal, 0, 255, 255 )
		guiSetFont ( aTab4.BansTotal, "default-bold-small" )
		aTab4.BansMore		= guiCreateButton ( 0.50, 0.94, 0.13, 0.04, "Mais...", true, aTab4.Tab, "listbans" )
		guiSetProperty(aTab4.BansMore, "NormalTextColour", "FF00FFBB")

		aTab5 = {}
		aTab5.Tab			= guiCreateTab ( "Chat", aTabPanel, "adminchat" )
		aTab5.AdminChat		= guiCreateMemo ( 0.03, 0.05, 0.75, 0.85, "", true, aTab5.Tab )
						  guiSetProperty ( aTab5.AdminChat, "ReadOnly", "true" )
		aTab5.AdminPlayers	= guiCreateGridList ( 0.79, 0.05, 0.18, 0.80, true, aTab5.Tab )
						  guiGridListAddColumn ( aTab5.AdminPlayers, "Admins", 0.90 )
	    aTab5.AdminChatSound	= guiCreateCheckBox ( 0.79, 0.86, 0.18, 0.04, "Tocar som", true, true, aTab5.Tab )
		guiSetFont ( aTab5.AdminChatSound, "default-bold-small" )
		guiSetProperty(aTab5.AdminChatSound, "NormalTextColour", "FFFF0000")	
		aTab5.AdminText		= guiCreateEdit ( 0.03, 0.92, 0.80, 0.06, "", true, aTab5.Tab )
		aTab5.AdminSay		= guiCreateButton ( 0.85, 0.92, 0.10, 0.06, "Enviar", true, aTab5.Tab )
		guiSetProperty(aTab5.AdminSay, "NormalTextColour", "FF00FFBB")
		--aTab5.AdminChatHelp	= guiCreateButton ( 0.94, 0.92, 0.03, 0.06, "?", true, aTab5.Tab )

		aTab6 = {}
		aTab6.Tab			= guiCreateTab ( "Opções", aTabPanel )
		
						  guiCreateHeader ( 0.03, 0.05, 0.10, 0.05, "Menu:", true, aTab6.Tab )
		aTab6.OutputPlayer	= guiCreateCheckBox ( 0.05, 0.10, 0.55, 0.04, "Copia informações do jogador selecionado.", false, true, aTab6.Tab )
				guiSetFont ( aTab6.OutputPlayer, "default-bold-small" )
		guiSetProperty(aTab6.OutputPlayer, "NormalTextColour", "FFFFFFFF")	
				playdat=		  guiCreateLabel ( 0.08, 0.15, 0.55, 0.04, "Isto pode ser útil para copiar dados dos jogadores.", true, aTab6.Tab )
		guiLabelSetColor ( playdat, 255, 0, 0 )
		guiSetFont ( playdat, "default-bold-small" ) 				  
		aTab6.AdminChatOutput 	= guiCreateCheckBox ( 0.05, 0.20, 0.55, 0.04, "Msg do chat do painel admin, no chat do jogo.", true, true, aTab6.Tab )
		guiSetFont ( aTab6.AdminChatOutput, "default-bold-small" )
		guiSetProperty(aTab6.AdminChatOutput, "NormalTextColour", "FFFFFFFF")			


					guiCreateHeader (  0.03, 0.30, 0.47, 0.04, "Aparência:", true, aTab6.Tab )
						  guiCreateHeader ( 0.63, 0.05, 0.10, 0.05, "Conta:", true, aTab6.Tab )
		aTab6.AutoLogin		= guiCreateCheckBox ( 0.65, 0.10, 0.47, 0.04, "Auto-login by serial", false, true, aTab6.Tab )
						  guiSetVisible ( aTab6.AutoLogin, false )	-- Not used
					guiCreateHeader ( 0.63, 0.15, 0.25, 0.05, "Alterar senha:", true, aTab6.Tab )
				oldsenha= guiCreateLabel ( 0.65, 0.20, 0.15, 0.05, "Senha antiga:", true, aTab6.Tab )
		guiLabelSetColor ( oldsenha, 0, 255, 255 )
		guiSetFont ( oldsenha, "default-bold-small" ) 				  
			newsenha=	  guiCreateLabel ( 0.65, 0.25, 0.15, 0.05, "Nova senha:", true, aTab6.Tab )
		guiLabelSetColor ( newsenha, 0, 255, 255 )
		guiSetFont ( newsenha, "default-bold-small" ) 				  
					senhconf=	  guiCreateLabel ( 0.65, 0.30, 0.15, 0.05, "Confirmar:", true, aTab6.Tab )
		guiLabelSetColor ( senhconf, 0, 255, 255 )
		guiSetFont ( senhconf, "default-bold-small" ) 			  
		aTab6.PasswordOld		= guiCreateEdit ( 0.80, 0.20, 0.15, 0.045, "", true, aTab6.Tab )
		aTab6.PasswordNew		= guiCreateEdit ( 0.80, 0.25, 0.15, 0.045, "", true, aTab6.Tab )
		aTab6.PasswordConfirm	= guiCreateEdit ( 0.80, 0.30, 0.15, 0.045, "", true, aTab6.Tab )
						  guiEditSetMasked ( aTab6.PasswordOld, true )
						  guiEditSetMasked ( aTab6.PasswordNew, true )
						  guiEditSetMasked ( aTab6.PasswordConfirm, true )
		aTab6.PasswordChange	= guiCreateButton ( 0.85, 0.35, 0.10, 0.04, "Aplicar", true, aTab6.Tab )
				guiSetProperty(aTab6.PasswordChange, "NormalTextColour", "FF00FFBB")
						  guiCreateHeader ( 0.03, 0.65, 0.20, 0.055, "Performance:", true, aTab6.Tab )
						  guiCreateStaticImage ( 0.03, 0.69, 0.94, 0.0025, "client\\images\\dot.png", true, aTab6.Tab )
			priori=			  guiCreateLabel ( 0.05, 0.71, 0.30, 0.055, "Prioridade de desempenho:", true, aTab6.Tab )
		guiLabelSetColor ( priori, 255, 255, 255 )
		guiSetFont ( priori, "default-bold-small" ) 			  
				memoria=		  guiCreateLabel ( 0.11, 0.76, 0.15, 0.05, "Memoria", true, aTab6.Tab )
		guiLabelSetColor ( memoria, 0, 255, 255 )
		guiSetFont ( memoria, "default-bold-small" ) 				  
					ayto=	  guiCreateLabel ( 0.11, 0.81, 0.15, 0.05, "Automático", true, aTab6.Tab )					
		guiLabelSetColor ( ayto, 0, 255, 255 )
		guiSetFont ( ayto, "default-bold-small" ) 						
					velo=	  guiCreateLabel ( 0.11, 0.86, 0.15, 0.05, "Velocidade", true, aTab6.Tab )
		guiLabelSetColor ( velo, 0, 255, 255 )
		guiSetFont ( velo, "default-bold-small" )  
						  
		aTab6.PerformanceRAM	= guiCreateRadioButton ( 0.07, 0.75, 0.05, 0.055, "", true, aTab6.Tab )
		aTab6.PerformanceAuto	= guiCreateRadioButton ( 0.07, 0.80, 0.05, 0.055, "", true, aTab6.Tab )
		aTab6.PerformanceCPU	= guiCreateRadioButton ( 0.07, 0.85, 0.05, 0.055, "", true, aTab6.Tab )
						  if ( aGetSetting ( "performance" ) == "RAM" ) then guiRadioButtonSetSelected ( aTab6.PerformanceRAM, true )
						  elseif ( aGetSetting ( "performance" ) == "CPU" ) then guiRadioButtonSetSelected ( aTab6.PerformanceCPU, true )
						  else guiRadioButtonSetSelected ( aTab6.PerformanceAuto, true ) end
		aTab6.PerformanceAdvanced = guiCreateButton ( 0.05, 0.91, 0.11, 0.04, "Avançado", false, aTab6.Tab )
		guiSetProperty(aTab6.PerformanceAdvanced , "NormalTextColour", "FF00FFBB")
		aPerformance()
					delayed=   	  guiCreateLabel ( 0.70, 0.90, 0.19, 0.055, "Taxa de delay(MS):", true, aTab6.Tab )
		guiLabelSetColor ( delayed, 0, 255, 255 )
		guiSetFont ( delayed, "default-bold-small" )
		aTab6.RefreshDelay	= guiCreateEdit ( 0.89, 0.90, 0.08, 0.045, "50", true, aTab6.Tab )

		if ( aGetSetting ( "outputPlayer" ) ) then guiCheckBoxSetSelected ( aTab6.OutputPlayer, true ) end
		if ( aGetSetting ( "adminChatOutput" ) ) then guiCheckBoxSetSelected ( aTab6.AdminChatOutput, true ) end
		if ( aGetSetting ( "adminChatSound" ) ) then guiCheckBoxSetSelected ( aTab5.AdminChatSound, true ) end
		--if ( tonumber ( aGetSetting ( "adminChatLines" ) ) ) then guiSetText ( aTab6.AdminChatLines, aGetSetting ( "adminChatLines" ) ) end
		if ( ( tonumber ( aGetSetting ( "refreshDelay" ) ) ) and ( tonumber ( aGetSetting ( "refreshDelay" ) ) >= 50 ) ) then guiSetText ( aTab6.RefreshDelay, aGetSetting ( "refreshDelay" ) ) end

		addEventHandler ( "aClientLog", _root, aClientLog )
		addEventHandler ( "aClientAdminChat", _root, aClientAdminChat )
		addEventHandler ( "aClientSync", _root, aClientSync )
		addEventHandler ( "aMessage", _root, aMessage )
		addEventHandler ( "aClientResourceStart", _root, aClientResourceStart )
		addEventHandler ( "aClientResourceStop", _root, aClientResourceStop )
		addEventHandler ( "aClientPlayerJoin", _root, aClientPlayerJoin )
		addEventHandler ( "onClientPlayerQuit", _root, aClientPlayerQuit )
		addEventHandler ( "onClientMouseEnter", _root, aClientMouseEnter )
		addEventHandler ( "onClientGUIClick", aAdminForm, aClientClick )
		addEventHandler ( "onClientGUIScroll", aAdminForm, aClientScroll )
		addEventHandler ( "onClientGUIDoubleClick", aAdminForm, aClientDoubleClick )
		addEventHandler ( "onClientGUIDoubleClick", aTab1.VehicleOptions, aClientDoubleClick )
		addEventHandler ( "onClientGUIAccepted", aAdminForm, aClientGUIAccepted )
		addEventHandler ( "onClientGUIChanged", aAdminForm, aClientGUIChanged )
		addEventHandler ( "onClientCursorMove", _root, aClientCursorMove )
		addEventHandler ( "onClientRender", _root, aClientRender )
		addEventHandler ( "onClientPlayerChangeNick", _root, aClientPlayerChangeNick )
		addEventHandler ( "onClientResourceStop", _root, aMainSaveSettings )
		addEventHandler ( "onClientGUITabSwitched", aTabPanel, aClientGUITabSwitched )

		bindKey ( "arrow_d", "down", aPlayerListScroll, 1 )
		bindKey ( "arrow_u", "down", aPlayerListScroll, -1 )

		triggerServerEvent ( "aSync", localPlayer, "players" )
		if ( hasPermissionTo ( "command.listmessages" ) ) then triggerServerEvent ( "aSync", localPlayer, "messages" ) end
		triggerServerEvent ( "aSync", localPlayer, "server" )
		triggerEvent ( "onAdminInitialize", resourceRoot )
		showCursor ( true )

		if getVersion().sortable and getVersion().sortable < "1.0.4-9.02436" then
			guiSetText ( aAdminForm, "Warning - Admin Panel not compatible with server version" )
			guiLabelSetHorizontalAlign ( guiCreateLabel ( 0.30, 0.11, 0.4, 0.04, "Upgrade server or downgrade Admin Panel", true, aAdminForm ), "center" )
		end
	end
	guiSetVisible ( aAdminForm, true )
	showCursor ( true )
	-- If the camera target was on another player, select him in the player list
	local element = getCameraTarget()
	if element and getElementType(element)=="vehicle" then
		element = getVehicleController(element)
	end
	if element and getElementType(element)=="player" and element ~= localPlayer then
		for row=0,guiGridListGetRowCount( aTab1.PlayerList )-1 do
			if ( guiGridListGetItemPlayerName ( aTab1.PlayerList, row, 1 ) == getPlayerName ( element ) ) then
				guiGridListSetSelectedItem ( aTab1.PlayerList, row, 1 )
				break
			end
		end
	end
    guiSetInputMode ( "no_binds_when_editing" )
end

--addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),aAdminMenu)








function aAdminMenuClose ( destroy )
	if ( destroy ) then
		aMainSaveSettings ()
		aPlayers = {}
		aWeathers = {}
		aBans = {}
		removeEventHandler ( "aClientLog", _root, aClientLog )
		removeEventHandler ( "aClientAdminChat", _root, aClientAdminChat )
		removeEventHandler ( "aClientSync", _root, aClientSync )
		removeEventHandler ( "aMessage", _root, aMessage )
		removeEventHandler ( "aClientResourceStart", _root, aClientResourceStart )
		removeEventHandler ( "aClientResourceStop", _root, aClientResourceStop )
		removeEventHandler ( "aClientPlayerJoin", _root, aClientPlayerJoin )
		removeEventHandler ( "onClientPlayerQuit", _root, aClientPlayerQuit )
		removeEventHandler ( "onClientMouseEnter", _root, aClientMouseEnter )
		removeEventHandler ( "onClientGUIClick", aAdminForm, aClientClick )
		removeEventHandler ( "onClientGUIScroll", aAdminForm, aClientScroll )
		removeEventHandler ( "onClientGUIDoubleClick", aAdminForm, aClientDoubleClick )
		removeEventHandler ( "onClientGUIDoubleClick", aTab1.VehicleOptions, aClientDoubleClick )
		removeEventHandler ( "onClientGUIAccepted", aAdminForm, aClientGUIAccepted )
		removeEventHandler ( "onClientGUIChanged", aAdminForm, aClientGUIChanged )
		removeEventHandler ( "onClientCursorMove", _root, aClientCursorMove )
		removeEventHandler ( "onClientRender", _root, aClientRender )
		removeEventHandler ( "onClientPlayerChangeNick", _root, aClientPlayerChangeNick )
		removeEventHandler ( "onClientResourceStop", _root, aMainSaveSettings )
		unbindKey ( "arrow_d", "down", aPlayerListScroll )
		unbindKey ( "arrow_u", "down", aPlayerListScroll )
		destroyElement ( aTab1.VehicleOptions )
		destroyElement ( aAdminForm )
		aAdminForm = nil
	else
		guiSetVisible ( aTab1.VehicleOptions, false )
		guiSetVisible ( aAdminForm, false )
	end
	showCursor ( false )
    guiSetInputMode ( "allow_binds")
end

function aMainSaveSettings ()
	aSetSetting ( "outputPlayer", guiCheckBoxGetSelected ( aTab6.OutputPlayer ) )
	aSetSetting ( "adminChatOutput", guiCheckBoxGetSelected ( aTab6.AdminChatOutput ) )
	aSetSetting ( "adminChatSound", guiCheckBoxGetSelected ( aTab5.AdminChatSound ) )
	--aSetSetting ( "adminChatLines", guiGetText ( aTab6.AdminChatLines ) )
	aSetSetting ( "refreshDelay", guiGetText ( aTab6.RefreshDelay ) )
	aSetSetting ( "currentWeapon", aCurrentWeapon )
	aSetSetting ( "currentAmmo", aCurrentAmmo )
	aSetSetting ( "currentVehicle", aCurrentVehicle )
	aSetSetting ( "currentSlap", aCurrentSlap )
	if ( guiRadioButtonGetSelected ( aTab6.PerformanceRAM ) ) then aSetSetting ( "performance", "RAM" )
	elseif ( guiRadioButtonGetSelected ( aTab6.PerformanceCPU ) ) then aSetSetting ( "performance", "CPU" )
	else aSetSetting ( "performance", "Auto" ) end
end

function aAdminRefresh ()
	if ( guiGridListGetSelectedItem ( aTab1.PlayerList ) ~= -1 ) then
		local player = getPlayerFromName ( guiGridListGetItemPlayerName ( aTab1.PlayerList, guiGridListGetSelectedItem( aTab1.PlayerList ), 1 ) )
		if ( player and aPlayers[player] ) then
			guiSetText ( aTab1.Name, "Nome: "..aPlayers[player]["name"]:gsub( "#%x%x%x%x%x%x", "" ) )
			guiSetText ( aTab1.Mute, iif ( aPlayers[player]["mute"], "Desmutar", "Mutar" ) )
			guiSetText ( aTab1.Freeze, iif ( aPlayers[player]["freeze"], "Descongelar", "Congelar" ) )
			--guiSetText ( aTab1.Username, "Community Username: "..( aPlayers[player]["username"] or "" ) )
			guiSetText ( aTab1.Version, "Versão: "..( aPlayers[player]["version"] or "" ) )
			guiSetText ( aTab1.Accountname, "Usuario: "..( aPlayers[player]["accountname"] or "" ) )
			guiSetText ( aTab1.Groups, "Equipe: "..( aPlayers[player]["groups"] or "Nenhuma" ) )
			guiSetText ( aTab1.ACDetected, "AC Detected: "..( aPlayers[player]["acdetected"] or "" ) )
			guiSetText ( aTab1.ACD3D, "D3D9.DLL: "..( aPlayers[player]["d3d9dll"] or "" ) )
			guiSetText ( aTab1.ACModInfo, "Img Mods: "..( aPlayers[player]["imgmodsnum"] or "" ) )
			if ( isPedDead ( player ) ) then guiSetText ( aTab1.Health, "Vida: Está morto" )
			else guiSetText ( aTab1.Health, "Vida: "..math.ceil ( getElementHealth ( player ) ).."%" ) end
			guiSetText ( aTab1.Armour, "Colete: "..math.ceil ( getPedArmor ( player ) ).."%" )
			guiSetText ( aTab1.Skin, "Skin: "..iif ( getElementModel ( player ), getElementModel ( player ), "N/A" ) )
			if ( getPlayerTeam ( player ) ) then guiSetText ( aTab1.Team, "Equipe: "..getTeamName ( getPlayerTeam ( player ) ) )
			else guiSetText ( aTab1.Team, "Equipe: Nenhuma" ) end
			guiSetText ( aTab1.Ping, "Ping: "..getPlayerPing ( player ) )
			guiSetText ( aTab1.Money, "Dinheiro: "..( aPlayers[player]["money"] or 0 ) )
			if ( getElementDimension ( player ) ) then guiSetText ( aTab1.Dimension, "Dimensão: "..getElementDimension ( player ) ) end
			if ( getElementInterior ( player ) ) then guiSetText ( aTab1.Interior, "Interior: "..getElementInterior ( player ) ) end
			guiSetText ( aTab1.JetPack, iif ( doesPedHaveJetPack ( player ), "Remover JetPack", "JetPack" ) )
			if ( getPedWeapon ( player ) ) then guiSetText ( aTab1.Weapon, "Arma: "..getWeaponNameFromID ( getPedWeapon ( player ) ).." (ID: "..getPedWeapon ( player )..")" ) end
			local x, y, z = getElementPosition ( player )
			guiSetText ( aTab1.Area, "Area: "..iif ( getZoneName ( x, y, z, false ) == getZoneName ( x, y, z, true ), getZoneName ( x, y, z, false ), getZoneName ( x, y, z, false ).." ("..getZoneName ( x, y, z, true )..")" ) )
			guiSetText ( aTab1.PositionX, "X: "..x )
			guiSetText ( aTab1.PositionY, "Y: "..y )
			guiSetText ( aTab1.PositionZ, "Z: "..z )
			local vehicle = getPedOccupiedVehicle ( player )
			if ( vehicle ) then
				guiSetText ( aTab1.Vehicle, "Veiculo: "..getVehicleName ( vehicle ).." (ID: "..getElementModel ( vehicle )..")" )
				guiSetText ( aTab1.VehicleHealth, "Dano no veiculo: "..math.ceil ( getElementHealth ( vehicle ) ).."%" )
			else
				guiSetText ( aTab1.Vehicle, "Veiculo: nenhum" )
				guiSetText ( aTab1.VehicleHealth, "Dano no veiculo: 0%" )
			end
			if ( aPlayers[player]["admin"] ) then
				guiSetText(aTab1.Admin, "Remover permissões")
			else
				guiSetText(aTab1.Admin, "Dar permissões")
			end
			return player
		end
	end
end

function aClientSync ( type, table )
	if ( type == "player" and aPlayers[source] ) then
		for type, data in pairs ( table ) do
			aPlayers[source][type] = data
		end
	elseif ( type == "players" ) then
		aPlayers = table
	elseif ( type == "resources" ) then
		local bInclMaps = guiCheckBoxGetSelected ( aTab2.ResourceInclMaps )
		aResources = table
		for id, resource in ipairs(table) do
			if bInclMaps or resource["type"] ~= "map" then
				local row = guiGridListAddRow ( aTab2.ResourceList )
				guiGridListSetItemText ( aTab2.ResourceList, row, 1, resource["name"], false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 2, resource["numsettings"] > 0 and tostring(resource["numsettings"]) or "", false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 3, resource["state"], false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 4, resource["fullName"], false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 5, resource["author"], false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 6, resource["version"], false, false )
			end
		end
	elseif ( type == "loggedout" ) then
		aAdminDestroy()
	elseif ( type == "admins" ) then
		--if ( guiGridListGetRowCount ( aTab5.AdminPlayers ) > 0 ) then guiGridListClear ( aTab5.AdminPlayers ) end
		for id, player in ipairs(getElementsByType("player")) do
			if ( table[player]["admin"] == false ) and ( player == localPlayer ) then
				aAdminDestroy()
				break
			elseif aPlayers[player] then
				aPlayers[player]["groups"] = table[player]["groups"]
				if ( table[player]["chat"] ) then
					local id = 0
					local exists = false
					while ( id <= guiGridListGetRowCount( aTab5.AdminPlayers ) ) do
						if ( guiGridListGetItemPlayerName ( aTab5.AdminPlayers, id, 1 ) == getPlayerName ( player ) ) then
							exists = true
						end
						id = id + 1
					end
					if ( exists == false ) then guiGridListSetItemPlayerName ( aTab5.AdminPlayers, guiGridListAddRow ( aTab5.AdminPlayers ), 1, getPlayerName ( player ), false, false ) end
				end
			end
		end
	elseif ( type == "server" ) then
		guiSetText ( aTab3.Server, "Servidor: "..table["name"] )
		guiSetText ( aTab3.Players, "Jogadores: "..#getElementsByType ( "player" ).."/"..table["players"] )
		guiSetText ( aTab3.Password, "Senha: "..( table["password"] or "nenhuma" ) )
		guiSetText ( aTab3.GameType, "Tipo de jogo: "..( table["game"] or "nenhum" ) )
		guiSetText ( aTab3.MapName, "Nome do mapa: "..( table["map"] or "nenhum" ) )
		guiSetText ( aTab3.FPSCurrent, "Limitar FPS: "..( table["fps"] or "N/A" ) )
		guiSetText ( aTab3.FPS, table["fps"] or "38" )
	elseif ( type == "bansdirty" ) then
		g_GotLatestBansList = false
		if aAdminForm and guiGetVisible ( aAdminForm ) and guiGetSelectedTab( aTabPanel ) == aTab4.Tab then
			-- Request full bans list if bans tab is displayed when 'bansdirty' is received
			triggerServerEvent ( "aSync", localPlayer, "bans" )
		end
	elseif ( type == "bans" or type == "bansmore" ) then
		if type == "bans" then
			g_GotLatestBansList = true
			guiGridListClear ( aTab4.BansList )
			aBans = {}
			aBans["Serial"] = {}
			aBans["IP"] = {}
		end
		local total = tonumber(table.total) or 0
		local amount = guiGridListGetRowCount( aTab4.BansList ) + #table
		guiSetText( aTab4.BansTotal, "Mostrando  " .. amount .. " / " .. total .. "  bans" )
		if g_GotLatestBansList then
			for i=1,#table do
				local ban = table[i]
				if ban.serial then
					aBans["Serial"][ban.serial] = ban
				end
				if ban.ip then
					aBans["IP"][ban.ip] = ban
				end
				local time, date = "-", "-"
				if ban.seconds then
					local realTime = getRealTime( ban.seconds )
					time = string.format("%02d:%02d", realTime.hour, realTime.minute )
					date = string.format("%04d-%02d-%02d", realTime.year + 1900, realTime.month + 1, realTime.monthday )
				end
				local reason = ban["reason"] and ban["reason"]~="nil" and ban["reason"] or ""
				local row = guiGridListAddRow ( aTab4.BansList )
				guiGridListSetItemText ( aTab4.BansList, row, 1, ban["nick"]	or "n/a", false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 2, ban.ip			or "n/a", false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 3, ban.serial		or "n/a", false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 4, ban["banner"]	or "n/a", false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 5, date,					false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 6, time,					false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 7, reason, false, false )
			end
		end
	elseif ( type == "messages" ) then
		local prev = tonumber ( string.sub ( guiGetText ( aTab1.Messages ), 1, 1 ) )
		if ( prev < table["unread"] ) then
			playSoundFrontEnd ( 18 )
		end
		guiSetText ( aTab1.Messages, table["unread"].."/"..table["total"].." mensagens" )
		
	end
end

function aClientGUITabSwitched( selectedTab )
	if getElementParent( selectedTab ) == aTabPanel then
		if selectedTab == aTab2.Tab then
			-- Handle initial update of resources list
			if guiGridListGetRowCount( aTab2.ResourceList ) == 0 then
				if ( hasPermissionTo ( "command.listresources" ) ) then 
					triggerServerEvent ( "aSync", localPlayer, "resources" ) 
				end
			end
		elseif selectedTab == aTabMap.Tab then
			-- Handle initial update of map list
			if guiGridListGetRowCount( aTabMap.MapList ) == 0 then
				if ( hasPermissionTo ( "command.listresources" ) ) then 
					triggerServerEvent ( "getMaps_s", localPlayer, localPlayer, true ) 
				end
			end
		elseif selectedTab == aTab4.Tab then
			if not g_GotLatestBansList then
				-- Request full bans list if bans tab is selected and current list is out of date
				triggerServerEvent ( "aSync", localPlayer, "bans" )
			end
		end	
	end 
end

function aMessage ( )

end

function aClientResourceStart ( resource )
	local id = 0
	while ( id <= guiGridListGetRowCount( aTab2.ResourceList ) ) do
		if ( guiGridListGetItemText ( aTab2.ResourceList, id, 1 ) == resource ) then
			guiGridListSetItemText ( aTab2.ResourceList, id, 3, "iniciado", false, false )
		end
		id = id + 1
	end
end

function aClientResourceStop ( resource )
	local id = 0
	while ( id <= guiGridListGetRowCount( aTab2.ResourceList ) ) do
		if ( guiGridListGetItemText ( aTab2.ResourceList, id, 1 ) == resource ) then
			guiGridListSetItemText ( aTab2.ResourceList, id, 3, "parado", false, false )
		end
		id = id + 1
	end
end

function aClientPlayerJoin ( ip, username, accountname, serial, admin, country )
	if ip == false and serial == false then
		-- Update country only
		if aPlayers[source] then
			aPlayers[source]["country"] = country
		end
		return
	end
	aPlayers[source] = {}
	aPlayers[source]["name"] = getPlayerName ( source )
	aPlayers[source]["IP"] = ip
	aPlayers[source]["username"] = username or "N/A"
	aPlayers[source]["accountname"] = accountname or "N/A"
	aPlayers[source]["serial"] = serial
	aPlayers[source]["admin"] = admin
	aPlayers[source]["country"] = country
	aPlayers[source]["acdetected"] = "..."
	aPlayers[source]["d3d9dll"] = ""
	aPlayers[source]["imgmodsnum"] = ""
	local row = guiGridListAddRow ( aTab1.PlayerList )
	guiGridListSetItemPlayerName ( aTab1.PlayerList, row, 1, getPlayerName ( source ), false, false )
	if ( admin ) then
		local row = guiGridListAddRow ( aTab5.AdminPlayers )
		guiGridListSetItemPlayerName ( aTab5.AdminPlayers, row, 1, getPlayerName ( source ), false, false )
	end
	if ( aSpectator.PlayerList ) then
		local row = guiGridListAddRow ( aSpectator.PlayerList )
		guiGridListSetItemPlayerName ( aSpectator.PlayerList, row, 1, getPlayerName ( source ), false, false )
	end
end

function aClientPlayerQuit ()
	local id = 0
	while ( id <= guiGridListGetRowCount( aTab1.PlayerList ) ) do
		if ( guiGridListGetItemPlayerName ( aTab1.PlayerList, id, 1 ) == getPlayerName ( source ) ) then
			guiGridListRemoveRow ( aTab1.PlayerList, id )
		end
		id = id + 1
	end
	if ( aPlayers[source] and aPlayers[source]["admin"] ) then
		local id = 0
		while ( id <= guiGridListGetRowCount( aTab5.AdminPlayers ) ) do
			if ( guiGridListGetItemPlayerName ( aTab5.AdminPlayers, id, 1 ) == getPlayerName ( source ) ) then
				guiGridListRemoveRow ( aTab5.AdminPlayers, id )
			end
			id = id + 1
		end
	end
	if ( aSpectator.PlayerList ) then
		local id = 0
		while ( id <= guiGridListGetRowCount( aSpectator.PlayerList ) ) do
			if ( guiGridListGetItemPlayerName ( aSpectator.PlayerList, id, 1 ) == getPlayerName ( source ) ) then
				guiGridListRemoveRow ( aSpectator.PlayerList, id )
			end
			id = id + 1
		end
	end
	aPlayers[source] = nil
end

function aPlayerListScroll ( key, state, inc )
	if ( not guiGetVisible ( aAdminForm ) ) then return end
	local max = guiGridListGetRowCount ( aTab1.PlayerList )
	if ( max <= 0 ) then return end
	local current = guiGridListGetSelectedItem ( aTab1.PlayerList )
	local next = current + inc
	max = max - 1
	if ( current == -1 ) then
		guiGridListSetSelectedItem ( aTab1.PlayerList, 0, 1 )
	elseif ( next > max ) then return
	elseif ( next < 0 ) then return
	else
		guiGridListSetSelectedItem ( aTab1.PlayerList, next, 1 )
	end
	local oldsource = source
	source = aTab1.PlayerList;
	aClientClick ( "left" )
	source = oldsource
end

function aClientPlayerChangeNick ( oldNick, newNick )
	local lists = { aTab1.PlayerList, aTab5.AdminPlayers, aSpectator.PlayerList }
	for _,gridlist in ipairs(lists) do
		for row=0,guiGridListGetRowCount(gridlist)-1 do
			if ( guiGridListGetItemPlayerName ( gridlist, row, 1 ) == oldNick ) then
				guiGridListSetItemPlayerName ( gridlist, row, 1, newNick, false, false )
			end
		end
	end
end

function aClientLog ( text )
	if text == "deleted" then
		guiGridListClear ( aTab2.ResourceList )
		triggerServerEvent ( "aSync", localPlayer, "resources" )	
	end
	text = "#"..aLogLines..": "..text
	if ( guiGetText ( aTab2.LogLine1 ) == "" ) then guiSetText ( aTab2.LogLine1, text )
	elseif ( guiGetText ( aTab2.LogLine2 ) == "" ) then guiSetText ( aTab2.LogLine2, text )
	elseif ( guiGetText ( aTab2.LogLine3 ) == "" ) then guiSetText ( aTab2.LogLine3, text )
	elseif ( guiGetText ( aTab2.LogLine4 ) == "" ) then guiSetText ( aTab2.LogLine4, text )
	elseif ( guiGetText ( aTab2.LogLine5 ) == "" ) then guiSetText ( aTab2.LogLine5, text )
	else
		guiSetText ( aTab2.LogLine1, guiGetText ( aTab2.LogLine2 ) )
		guiSetText ( aTab2.LogLine2, guiGetText ( aTab2.LogLine3 ) )
		guiSetText ( aTab2.LogLine3, guiGetText ( aTab2.LogLine4 ) )
		guiSetText ( aTab2.LogLine4, guiGetText ( aTab2.LogLine5 ) )
		guiSetText ( aTab2.LogLine5, text )
	end
	
	aLogLines = aLogLines + 1
end

function aClientAdminChat ( message )
	guiSetText ( aTab5.AdminChat, guiGetText ( aTab5.AdminChat )..""..getPlayerName ( source ):gsub( "#%x%x%x%x%x%x", "" )..": "..message )
	guiSetProperty ( aTab5.AdminChat, "CaratIndex", tostring ( string.len ( guiGetText ( aTab5.AdminChat ) ) ) )
	if ( guiCheckBoxGetSelected ( aTab6.AdminChatOutput ) ) then outputChatBox ( "* Admin Chat> "..getPlayerName ( source )..": #ff0000" ..message, 255, 255, 255 ,true) end
	if ( ( guiCheckBoxGetSelected ( aTab5.AdminChatSound ) ) and ( source ~= localPlayer ) ) then
    playSound("client/gui/adminchat.mp3")
	end
end

function aSetCurrentAmmo ( ammo )
	ammo = tonumber ( ammo )
	if ( ( ammo ) and ( ammo > 0 ) and ( ammo < 10000 ) ) then
		aCurrentAmmo = ammo
		return
	end
	outputChatBox ( "Valor de munição inválido", 255, 0, 0 )
end

function aClientGUIAccepted ( element )
	if ( element == aTab5.AdminText ) then
		local message = guiGetText ( aTab5.AdminText )
		if ( ( message ) and ( message ~= "" ) ) then 
			if ( gettok ( message, 1, 32 ) == "/clear" ) then guiSetText ( aTab5.AdminChat, "" )
			else triggerServerEvent ( "aAdminChat", localPlayer, message ) end
			guiSetText ( aTab5.AdminText, "" )
		end
	end
end

function aClientGUIChanged ()
	if ( source == aTab1.PlayerListSearch ) then
		guiGridListClear ( aTab1.PlayerList )
		local text = guiGetText ( source )
		if ( text == "" ) then
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				guiGridListSetItemPlayerName ( aTab1.PlayerList, guiGridListAddRow ( aTab1.PlayerList ), 1, getPlayerName ( player ), false, false )
			end
		else
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
					guiGridListSetItemPlayerName ( aTab1.PlayerList, guiGridListAddRow ( aTab1.PlayerList ), 1, getPlayerName ( player ), false, false )
				end
			end
		end
	elseif ( source == aTab2.ResourceListSearch ) then
		local bInclMaps = guiCheckBoxGetSelected ( aTab2.ResourceInclMaps )
		guiGridListClear ( aTab2.ResourceList )
		local text = string.lower(guiGetText(source))
		if ( text == "" ) then
			for id, resource in ipairs(aResources) do
				if bInclMaps or resource["type"] ~= "map" then
					local row = guiGridListAddRow ( aTab2.ResourceList )
					guiGridListSetItemText ( aTab2.ResourceList, row, 1, resource["name"], false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 2, resource["numsettings"] > 0 and tostring(resource["numsettings"]) or "", false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 3, resource["state"], false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 4, resource["fullName"], false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 5, resource["author"], false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 6, resource["version"], false, false )
				end
			end
		else
			for id, resource in ipairs(aResources) do
				if bInclMaps or resource["type"] ~= "map" then
					if string.find(string.lower(resource.name), text, 1, true) then
						local row = guiGridListAddRow ( aTab2.ResourceList )
						guiGridListSetItemText ( aTab2.ResourceList, row, 1, resource["name"], false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 2, resource["numsettings"] > 0 and tostring(resource["numsettings"]) or "", false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 3, resource["state"], false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 4, resource["fullName"], false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 5, resource["author"], false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 6, resource["version"], false, false )
					end
				end
			end
		end
	end
end

function aClientScroll ( element )
	if ( source == aTab6.MouseSense ) then
		guiSetText ( aTab6.MouseSenseCur, "Cursor sensivity: ("..string.sub ( guiScrollBarGetScrollPosition ( source ) / 50, 0, 4 )..")" )
	end
end

function aClientCursorMove ( rx, ry, x, y )
	
end

function aClientMouseEnter ( element )
	if ( getElementType ( source ) == "gui-button" ) then

	end
end

function aClientDoubleClick ( button )
	if ( source == aTab1.WeaponOptions ) then
		if ( guiGridListGetSelectedItem ( aTab1.WeaponOptions ) ~= -1 ) then
			aCurrentWeapon = getWeaponIDFromName ( guiGridListGetItemText ( aTab1.WeaponOptions, guiGridListGetSelectedItem ( aTab1.WeaponOptions ), 1 ) )
			local wep = guiGridListGetItemText ( aTab1.WeaponOptions, guiGridListGetSelectedItem ( aTab1.WeaponOptions ), 1 )
			wep = string.gsub ( wep, "Combat Shotgun", "Combat SG" )
			guiSetText ( aTab1.GiveWeapon, "Dar: "..wep.." " )
		end
		guiSetVisible ( aTab1.WeaponOptions, false )
	elseif ( source == aTab1.VehicleOptions ) then
		local item = guiGridListGetSelectedItem ( aTab1.VehicleOptions )
		if ( item ~= -1 ) then
			if ( guiGridListGetItemText ( aTab1.VehicleOptions, item, 1 ) ~= "" ) then
				aCurrentVehicle = tonumber ( guiGridListGetItemData ( aTab1.VehicleOptions, item, 1 ) )
				guiSetText ( aTab1.GiveVehicle, "Dar: "..guiGridListGetItemText ( aTab1.VehicleOptions, item, 1 ).." " )
			end
		end
		guiSetVisible ( aTab1.VehicleOptions, false )
	elseif ( source == aTab1.SlapOptions ) then
		if ( guiGridListGetSelectedItem ( aTab1.SlapOptions ) ~= -1 ) then
			aCurrentSlap = guiGridListGetItemText ( aTab1.SlapOptions, guiGridListGetSelectedItem ( aTab1.SlapOptions ), 1 )
			guiSetText ( aTab1.Slap, "Slap! "..aCurrentSlap.." _" )
			if ( aSpecSlap ) then guiSetText ( aSpecSlap, "Slap! "..aCurrentSlap.."hp" ) end
		end
		guiSetVisible ( aTab1.SlapOptions, false )
	elseif ( source == aTab2.ResourceList ) then
		if ( guiGridListGetSelectedItem ( aTab2.ResourceList ) ~= -1 ) then
			aManageSettings ( guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ) )
		end
	end
	if ( guiGetVisible ( aTab1.WeaponOptions ) ) then guiSetVisible ( aTab1.WeaponOptions, false ) end
	if ( guiGetVisible ( aTab1.VehicleOptions ) ) then guiSetVisible ( aTab1.VehicleOptions, false ) end
	if ( guiGetVisible ( aTab1.SlapOptions ) ) then guiSetVisible ( aTab1.SlapOptions, false ) end
end

function aClientClick ( button )
	if ( ( source == aTab1.WeaponOptions ) or ( source == aTab1.VehicleOptions ) or ( source == aTab1.SlapOptions ) ) then return
	else
		if ( guiGetVisible ( aTab1.WeaponOptions ) ) then guiSetVisible ( aTab1.WeaponOptions, false ) end
		if ( guiGetVisible ( aTab1.VehicleOptions ) ) then guiSetVisible ( aTab1.VehicleOptions, false ) end
		if ( guiGetVisible ( aTab1.SlapOptions ) ) then guiSetVisible ( aTab1.SlapOptions, false ) end
	end
	if ( button == "left" ) then
		-- TAB 1, PLAYERS
		if ( getElementParent ( source ) == aTab1.Tab ) then
			if ( source == aTab1.Messages ) then
				aViewMessages()
			elseif ( source == aTab1.ScreenShots ) then
				aPlayerScreenShot()
			elseif ( source == aTab1.PlayerListSearch ) then
				
			elseif ( source == aTab1.HideColorCodes ) then
				updateColorCodes()
			elseif ( source == aTab1.AnonAdmin ) then
				setAnonAdmin( guiCheckBoxGetSelected ( aTab1.AnonAdmin ) )
			elseif ( getElementType ( source ) == "gui-button" )  then
				if ( source == aTab1.GiveVehicle ) then guiBringToFront ( aTab1.VehicleDropDown )
				elseif ( source == aTab1.GiveWeapon ) then guiBringToFront ( aTab1.WeaponDropDown )
				elseif ( source == aTab1.Slap ) then guiBringToFront ( aTab1.SlapDropDown ) end
				if ( guiGridListGetSelectedItem ( aTab1.PlayerList ) == -1 ) then
					aMessageBox ( "Aviso", "Nenhum jogador selecionado!" )
				else
					local name = guiGridListGetItemPlayerName ( aTab1.PlayerList, guiGridListGetSelectedItem( aTab1.PlayerList ), 1 )
					local player = getPlayerFromName ( name )
					if ( source == aTab1.Kick ) then aInputBox ( "Expulsar "..name:gsub( "#%x%x%x%x%x%x", "" ), "Diga o motivo da expulsão: ", "", "kickPlayer", player )
					elseif ( source == aTab1.Ban ) then aBanInputBox ( player )
					elseif ( source == aTab1.Slap ) then triggerServerEvent ( "aPlayer", localPlayer, player, "slap", aCurrentSlap )
					elseif ( source == aTab1.Mute ) then if not aPlayers[player]["mute"] then aMuteInputBox ( player ) else aMessageBox ( "question", "Você quer desmutar o "..name:gsub( "#%x%x%x%x%x%x", "" ).."?", "unmute", player ) end
					elseif ( source == aTab1.Freeze ) then triggerServerEvent ( "aPlayer", localPlayer, player, "freeze" )
					elseif ( source == aTab1.Spectate ) then aSpectate ( player )
					elseif ( source == aTab1.Nick ) then aInputBox ( "Alterar nome", "Digite o novo nick do jogador:", name, "setNick", player )
					elseif ( source == aTab1.Shout ) then aInputBox ( "Shout", "Digite a advertência para o jogador:", "", "shout", player )
					elseif ( source == aTab1.SetHealth ) then aInputBox ( "Vida", "Digite o valor para a saúde:", "100", "setHealth", player )
					elseif ( source == aTab1.SetArmour ) then aInputBox ( "Colete", "Digite o valor do colete:", "100", "setArmor", player )
					elseif ( source == aTab1.SetTeam ) then aPlayerTeam ( player )
					elseif ( source == aTab1.SetSkin ) then aPlayerSkin ( player )
					elseif ( source == aTab1.SetInterior ) then aPlayerInterior ( player )
					elseif ( source == aTab1.JetPack ) then triggerServerEvent ( "aPlayer", localPlayer, player, "jetpack" )
					elseif ( source == aTab1.SetMoney ) then aInputBox ( "Dinheiro", "Digite o valor do dinheiro:", "0", "setMoney", player )
					elseif ( source == aTab1.SetStats ) then aPlayerStats ( player )
					elseif ( source == aTab1.SetDimension ) then aInputBox ( "Dimensão", "Digite a dimensão entre 0 a 65535:", "0", "setDimension", player)
					elseif ( source == aTab1.GiveVehicle ) then triggerServerEvent ( "aPlayer", localPlayer, player, "givevehicle", aCurrentVehicle )
					elseif ( source == aTab1.GiveWeapon ) then triggerServerEvent ( "aPlayer", localPlayer, player, "giveweapon", aCurrentWeapon, aCurrentAmmo )
					elseif ( source == aTab1.Warp ) then triggerServerEvent ( "aPlayer", localPlayer, player, "warp" )
					elseif ( source == aTab1.WarpTo ) then aPlayerWarp ( player )
					elseif ( source == aTab1.VehicleFix ) then triggerServerEvent ( "aVehicle", localPlayer, player, "repair" )
					elseif ( source == aTab1.VehicleBlow ) then triggerServerEvent ( "aVehicle", localPlayer, player, "blowvehicle" )
					elseif ( source == aTab1.VehicleDestroy ) then triggerServerEvent ( "aVehicle", localPlayer, player, "destroyvehicle" )
					elseif ( source == aTab1.VehicleCustomize ) then aVehicleCustomize ( player )
					elseif ( source == aTab1.Admin ) then
						if ( aPlayers[player]["admin"] ) then aMessageBox ( "Aviso", "Retirar permissões de "..name:gsub( "#%x%x%x%x%x%x", "" ).."?", "revokeAdmin", player )
						else aMessageBox ( "Aviso", "Dar permissões para "..name:gsub( "#%x%x%x%x%x%x", "" ).."?", "giveAdmin", player ) end
					elseif ( source == aTab1.ACModDetails ) then
						aViewModdetails(player)
					end
				end
			elseif ( source == aTab1.VehicleDropDown ) then
				local x1, y1 = guiGetPosition ( aAdminForm, false )
				local x2, y2 = guiGetPosition ( aTabPanel, false )
				local x3, y3 = guiGetPosition ( aTab1.Tab, false )
				local x4, y4 = guiGetPosition ( aTab1.GiveVehicle, false )
				guiSetPosition ( aTab1.VehicleOptions, x1 + x2 + x3 + x4, y1 + y2 + y3 + y4 + 20, false )
				guiSetVisible ( aTab1.VehicleOptions, true )
				guiBringToFront ( aTab1.VehicleOptions )
			elseif ( source == aTab1.WeaponDropDown ) then
				guiSetVisible ( aTab1.WeaponOptions, true )
				guiBringToFront ( aTab1.WeaponOptions )
			elseif ( source == aTab1.SlapDropDown ) then
				guiSetVisible ( aTab1.SlapOptions, true )
				guiBringToFront ( aTab1.SlapOptions )
			elseif ( source == aTab1.PlayerList ) then
				if ( guiGridListGetSelectedItem( aTab1.PlayerList ) ~= -1 ) then
					local player = aAdminRefresh ()
					if ( player ) then
						triggerServerEvent ( "aSync", localPlayer, "player", player )
						if ( ( guiCheckBoxGetSelected ( aTab6.OutputPlayer ) ) and ( player ) ) then
							outputConsole ( "Name: "..aPlayers[player]["name"]
										..", IP: "..aPlayers[player]["IP"]
										..", Serial: "..aPlayers[player]["serial"]
									--	..", Community Username: "..aPlayers[player]["username"]
										..", Account Name: "..aPlayers[player]["accountname"]
										..", D3D9.DLL: "..aPlayers[player]["d3d9dll"] )
						end
						guiSetText ( aTab1.IP, "IP: "..aPlayers[player]["IP"] )
						guiSetText ( aTab1.Serial, "Serial: "..aPlayers[player]["serial"] )
						--guiSetText ( aTab1.Username, "Community Username: "..aPlayers[player]["username"] )
						guiSetText ( aTab1.Accountname, "Usuario: "..aPlayers[player]["accountname"] )
						guiSetText ( aTab1.ACDetected, "AC Detected: "..aPlayers[player]["acdetected"] )
						guiSetText ( aTab1.ACD3D, "D3D9.DLL: "..aPlayers[player]["d3d9dll"] )
						guiSetText ( aTab1.ACModInfo, "Img Mods: "..aPlayers[player]["imgmodsnum"] )
						local countryCode = aPlayers[player]["country"]
						loadFlagImage ( aTab1.Flag, countryCode )
						if not countryCode then
							guiSetText ( aTab1.CountryCode, "" )
						else
							local x, y = guiGetPosition ( aTab1.IP, false )
							local width = guiLabelGetTextExtent ( aTab1.IP )
							guiSetPosition ( aTab1.Flag, x + width + 7, y + 4, false )
							guiSetPosition ( aTab1.CountryCode, x + width + 30, y, false )
							guiSetText ( aTab1.CountryCode, tostring( countryCode ) )
						end
						guiSetText ( aTab1.Version, "Versão: " .. ( aPlayers[player]["version"] or "" ) )
					end
				else
					guiSetText ( aTab1.Name, "Nome: N/A" )
					guiSetText ( aTab1.IP, "IP: N/A" )
					guiSetText ( aTab1.Serial, "Serial: N/A" )
					--guiSetText ( aTab1.Username, "Community Username: N/A" )
					guiSetText ( aTab1.Version, "Versão: N/A" )
					guiSetText ( aTab1.Accountname, "Usuario: N/A" )
					guiSetText ( aTab1.Groups, "Equipe: N/A" )
					guiSetText ( aTab1.ACDetected, "AC Detected: N/A" )
					guiSetText ( aTab1.ACD3D, "D3D9.DLL: N/A" )
					guiSetText ( aTab1.ACModInfo, "Img Mods: N/A" )
					guiSetText ( aTab1.Mute, "Mutar" )
					guiSetText ( aTab1.Freeze, "Congelar" )
					guiSetText ( aTab1.Admin, "Dar permissões" )
					guiSetText ( aTab1.Health, "Vida: 0%" ) 
					guiSetText ( aTab1.Armour, "Colete: 0%" )
					guiSetText ( aTab1.Skin, "Skin: N/A" )
					guiSetText ( aTab1.Team, "Equipe: Nenhuma" )
					guiSetText ( aTab1.Ping, "Ping: 0" )
					guiSetText ( aTab1.Money, "Dinheiro: 0" )
					guiSetText ( aTab1.Dimension, "Dimensão: 0" )
					guiSetText ( aTab1.Interior, "Interior: 0" )
					guiSetText ( aTab1.JetPack, "JetPack" )
					guiSetText ( aTab1.Weapon, "Arma: N/A" )
					guiSetText ( aTab1.Area, "Area: Desconhecida" )
					guiSetText ( aTab1.PositionX, "X: 0" )
					guiSetText ( aTab1.PositionY, "Y: 0" )
					guiSetText ( aTab1.PositionZ, "Z: 0" )
					guiSetText ( aTab1.Vehicle, "Veiculo: N/A" )
					guiSetText ( aTab1.VehicleHealth, "Dano no veiculo: 0%" )
					guiStaticImageLoadImage ( aTab1.Flag, "client\\images\\empty.png" )
					guiSetText ( aTab1.CountryCode, "" )
				end
			end
		-- TAB 2, RESOURCES
		elseif ( getElementParent ( source ) == aTab2.Tab ) then
			if ( source == aTab2.ResourceListSearch ) then
				
			elseif ( ( source == aTab2.ResourceStart ) or ( source == aTab2.ResourceRestart ) or ( source == aTab2.ResourceStop ) or ( source == aTab2.ResourceDelete ) or ( source == aTab2.ResourceSettings ) ) then
				if ( guiGridListGetSelectedItem ( aTab2.ResourceList ) == -1 ) then
					aMessageBox ( "Aviso", "Nenhum recurso selecionado!" )
				else
					if ( source == aTab2.ResourceStart ) then triggerServerEvent ( "aResource", localPlayer, guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ), "start" )
					elseif ( source == aTab2.ResourceRestart ) then triggerServerEvent ( "aResource", localPlayer, guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ), "restart" )
					elseif ( source == aTab2.ResourceStop ) then triggerServerEvent ( "aResource", localPlayer, guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ), "stop" )
					elseif ( source == aTab2.ResourceDelete ) then aMessageBox ( "warning", "Are you sure you want to stop and delete resource '" .. guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ) .. "' ?", "stopDelete", guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ) )
					elseif ( source == aTab2.ResourceSettings ) then aManageSettings ( guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ) ) )
					end
				end				
			elseif ( source == aTab2.ResourcesStopAll ) then aMessageBox ( "error", "Tem certeza de que deseja parar todos os recursos?", "stopAll" )
			elseif ( source == aTab2.ResourceList ) then
				guiSetVisible ( aTab2.ResourceFailture, false )
				if ( guiGridListGetSelectedItem ( aTab2.ResourceList ) ~= -1 ) then
					guiSetText(aTab2.ResourceName, "Nome: " .. guiGridListGetItemText(aTab2.ResourceList, guiGridListGetSelectedItem ( aTab2.ResourceList ), 4))
					guiSetText(aTab2.ResourceAuthor, "Autor: " .. guiGridListGetItemText(aTab2.ResourceList, guiGridListGetSelectedItem ( aTab2.ResourceList ), 5))
					guiSetText(aTab2.ResourceVersion, "Versão: " .. guiGridListGetItemText(aTab2.ResourceList, guiGridListGetSelectedItem ( aTab2.ResourceList ), 6))
					if ( guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 3 ) == "Falha no recurso" ) then
						guiSetVisible ( aTab2.ResourceFailture, true )
					end
				end
			elseif ( source == aTab2.ManageACL ) then
				aManageACL()
			elseif ( source == aTab2.ResourceRefresh or source == aTab2.ResourceInclMaps ) then
				guiGridListClear ( aTab2.ResourceList )
				triggerServerEvent ( "aSync", localPlayer, "resources" )
			elseif ( source == aTab2.ExecuteClient ) then
				if ( ( guiGetText ( aTab2.Command ) ) and ( guiGetText ( aTab2.Command ) ~= "" ) ) then aExecute ( guiGetText ( aTab2.Command ), true ) end
			elseif ( source == aTab2.ExecuteServer ) then
				if ( ( guiGetText ( aTab2.Command ) ) and ( guiGetText ( aTab2.Command ) ~= "" ) ) then triggerServerEvent ( "aExecute", localPlayer, guiGetText ( aTab2.Command ), true ) end
			elseif ( source == aTab2.Command ) then
				
				guiSetVisible ( aTab2.ExecuteAdvanced, false )
			elseif ( source == aTab2.ExecuteAdvanced ) then
				guiSetVisible ( aTab2.ExecuteAdvanced, false )
			end
		-- TAB 3, WORLD
		elseif ( getElementParent ( source ) == aTab3.Tab ) then
			if ( source == aTab3.SetGameType ) then aInputBox ( "Tipo de jogo", "Digite o tipo de jogo:", "", "setGameType" )
			elseif ( source == aTab3.SetMapName ) then aInputBox ( "Nome do mapa", "Digite o nome do mapa:", "", "setMapName" )
			elseif ( source == aTab3.SetWelcome ) then aInputBox ( "Mensagem de boas vindas", "Digite a mensagem de boas vindas:", "", "setWelcome" )
			elseif ( source == aTab3.SetPassword ) then aInputBox ( "Colocar senha", "Digite a senha do servidor: (maximo 32)", "", "setServerPassword" )
			elseif ( source == aTab3.Shutdown ) then aInputBox ( "Desligar servidor", "Digite o motivo para os jogadores:", "", "serverShutdown" )
			elseif ( source == aTab3.ResetPassword ) then triggerServerEvent ( "aServer", localPlayer, "setpassword", "" )
			elseif ( ( source == aTab3.WeatherInc ) or ( source == aTab3.WeatherDec ) ) then
				local id = tonumber ( gettok ( guiGetText ( aTab3.Weather ), 1, 32 ) )
				if ( id ) then
					if ( ( source == aTab3.WeatherInc ) and ( id < _weathers_max ) ) then guiSetText ( aTab3.Weather, ( id + 1 ).." ("..getWeatherNameFromID ( id + 1 )..")" )
					elseif ( ( source == aTab3.WeatherDec ) and ( id > 0 ) ) then guiSetText ( aTab3.Weather, ( id - 1 ).." ("..getWeatherNameFromID ( id - 1 )..")" ) end
				else
					guiSetText ( aTab3.Weather, ( 14 ).." ("..getWeatherNameFromID ( 14 )..")" ) 
				end
			elseif ( source == aTab3.WeatherSet ) then triggerServerEvent ( "aServer", localPlayer, "setweather", gettok ( guiGetText ( aTab3.Weather ), 1, 32 ) )
			elseif ( source == aTab3.WeatherBlend ) then triggerServerEvent ( "aServer", localPlayer, "blendweather", gettok ( guiGetText ( aTab3.Weather ), 1, 32 ) )
			elseif ( source == aTab3.TimeSet ) then triggerServerEvent ( "aServer", localPlayer, "settime", guiGetText ( aTab3.TimeH ), guiGetText ( aTab3.TimeM ) )
			elseif ( ( source == aTab3.SpeedInc ) or ( source == aTab3.SpeedDec ) ) then
				local value = tonumber ( guiGetText ( aTab3.Speed ) )
				if ( value ) then
					if ( ( source == aTab3.SpeedInc ) and ( value < 10 ) ) then guiSetText ( aTab3.Speed, tostring ( value + 1 ) )
					elseif ( ( source == aTab3.SpeedDec ) and ( value > 0 ) ) then guiSetText ( aTab3.Speed, tostring ( value - 1 ) ) end
				else
					guiSetText ( aTab3.Speed, "1" ) 
				end
			elseif ( source == aTab3.SpeedSet ) then triggerServerEvent ( "aServer", localPlayer, "setgamespeed", guiGetText ( aTab3.Speed ) )
			elseif ( source == aTab3.GravitySet ) then triggerServerEvent ( "aServer", localPlayer, "setgravity", guiGetText ( aTab3.Gravity ) )
			elseif ( source == aTab3.WavesSet ) then triggerServerEvent ( "aServer", localPlayer, "setwaveheight", guiGetText ( aTab3.Waves ) )
			elseif ( source == aTab3.FPSSet ) then 
			triggerServerEvent ( "aServer", localPlayer, "setfpslimit", guiGetText ( aTab3.FPS ) )
			triggerServerEvent ( "aSync", localPlayer, "server" )
			end
		-- TAB 4, BANS
		elseif ( getElementParent ( source ) == aTab4.Tab ) then
			if ( source == aTab4.Details ) then
				if ( guiGridListGetSelectedItem ( aTab4.BansList ) == -1 ) then
					aMessageBox ( "Aviso", "Ninguem da lista foi selecionado!" )
				else
					local selip = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 2 )
					local selserial = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 3 )
					aBanDetails ( aBans["Serial"][selserial] and selserial or selip )
				end
			elseif ( source == aTab4.Unban ) then
				if ( guiGridListGetSelectedItem ( aTab4.BansList ) == -1 ) then
					aMessageBox ( "Aviso", "Ninguem da lista foi selecionado!" )
				else
					local selip = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 2 )
					local selserial = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 3 )
					if ( aBans["Serial"][selserial] ) then aMessageBox ( "question", "Desbanir Serial "..selserial.."?", "unbanSerial", selserial )
					else aMessageBox ( "question", "Desbanir IP "..selip.."?", "unbanIP", selip ) end
				end
			elseif ( source == aTab4.UnbanIP ) then
				aInputBox ( "Desbanir IP", "Digite o IP para desbanir", "", "unbanIP" )
			elseif ( source == aTab4.UnbanSerial ) then
				aInputBox ( "Desbanir Serial", "Digite o serial para desbanir", "", "unbanSerial" )
			elseif ( source == aTab4.BanIP ) then
				aInputBox ( "Banir IP", "Digite o IP a ser banido", "", "banIP")
			elseif ( source == aTab4.BanSerial ) then
				aInputBox ( "Banir serial", "Digite o serial a ser banido:", "", "banSerial" )
			elseif ( source == aTab4.BansRefresh ) then
				guiGridListClear ( aTab4.BansList )
				triggerServerEvent ( "aSync", localPlayer, "bans" )
			elseif ( source == aTab4.BansMore ) then
				triggerServerEvent ( "aSync", localPlayer, "bansmore", guiGridListGetRowCount( aTab4.BansList ) )
			end
		-- TAB 5, ADMIN CHAT
		elseif ( getElementParent ( source ) == aTab5.Tab ) then
			if ( source == aTab5.AdminSay ) then
				local message = guiGetText ( aTab5.AdminText )
				if ( ( message ) and ( message ~= "" ) ) then
					if ( gettok ( message, 1, 32 ) == "/clear" ) then guiSetText ( aTab5.AdminChat, "" )
					else triggerServerEvent ( "aAdminChat", localPlayer, message ) end
					guiSetText ( aTab5.AdminText, "" )
				end
			elseif ( source == aTab5.AdminText ) then
				
			end
		-- TAB 6, OPTIONS
		elseif ( getElementParent ( source ) == aTab6.Tab ) then
			if ( source == aTab6.PerformanceCPU ) then
				for id, element in ipairs ( getElementChildren ( aPerformanceForm ) ) do
					if ( getElementType ( element ) == "gui-checkbox" ) then
						guiCheckBoxSetSelected ( element, false )
					end
				end
			elseif ( source == aTab6.PerformanceRAM ) then
				for id, element in ipairs ( getElementChildren ( aPerformanceForm ) ) do
					if ( getElementType ( element ) == "gui-checkbox" ) then
						guiCheckBoxSetSelected ( element, true )
					end
				end
			elseif ( source == aTab6.PerformanceAdvanced ) then
				aPerformance()
			elseif ( source == aTab6.AutoLogin ) then
				triggerServerEvent ( "aAdmin", localPlayer, "autologin", guiCheckBoxGetSelected ( aTab6.AutoLogin ) )
			elseif ( source == aTab6.PasswordOld ) then
				
			elseif ( source == aTab6.PasswordNew ) then
				
			elseif ( source == aTab6.PasswordConfirm ) then
				
			elseif ( source == aTab6.PasswordChange ) then
				local passwordNew, passwordConf = guiGetText ( aTab6.PasswordNew ), guiGetText ( aTab6.PasswordConfirm )
				if ( passwordNew == "" ) then aMessageBox ( "Aviso", "Digite a nova senha" )
				elseif ( passwordConf == "" ) then aMessageBox ( "Aviso", "Confirme a nova senha" )
				elseif ( string.len ( passwordNew ) < 4 ) then aMessageBox ( "Aviso", "A nova senha deve ter pelo menos 4 caracteres" )
				elseif ( passwordNew ~= passwordConf ) then aMessageBox ( "Aviso", "As senhas não se correspondem" )
				else triggerServerEvent ( "aAdmin", localPlayer, "password", guiGetText ( aTab6.PasswordOld ), passwordNew, passwordConf ) end
			end
		end
	elseif ( button == "right" ) then
		if ( source == aTab1.GiveWeapon ) then aInputBox ( "Munições", "Valor da munição varia de 1 a 9999", "1000", "setCurrentAmmo" )
		end
	end
end

function aClientRender ()
	if ( guiGetVisible ( aAdminForm ) ) then
		if ( getTickCount() >= aLastCheck ) then
			aAdminRefresh ()
			local th, tm = getTime()
			guiSetText ( aTab3.Players, "Jogadores: "..#getElementsByType ( "player" ).."/"..gettok ( guiGetText ( aTab3.Players ), 2, 47 ) )
			guiSetText ( aTab3.TimeCurrent,	string.format("Tempo: %02d:%02d", th, tm ) )
			guiSetText ( aTab3.GravityCurrent, "Gravidade: "..string.sub ( getGravity(), 0, 6 ) )
			guiSetText ( aTab3.SpeedCurrent, "Velocidade do jogo: "..getGameSpeed() )
			guiSetText ( aTab3.WeatherCurrent, "Tempo atual: "..getWeather().." ("..getWeatherNameFromID ( getWeather() )..")" )
			local refreshTime = tonumber ( guiGetText ( aTab6.RefreshDelay ) )
			if ( ( refreshTime ) and ( refreshTime >= 20 ) ) then aLastCheck = getTickCount() + refreshTime
			else aLastCheck = getTickCount() + 50 end
		end
		if ( getTickCount() >= aLastSync ) then
			triggerServerEvent ( "aSync", localPlayer, "admins" )
			aLastSync = getTickCount() + 15000
		end
	end
end


function updateColorCodes()
	local lists = { aTab1.PlayerList, aTab5.AdminPlayers, aSpectator.PlayerList }
	for _,gridlist in ipairs(lists) do
		for row=0,guiGridListGetRowCount(gridlist)-1 do
			guiGridListSetItemPlayerName( gridlist, row, 1, guiGridListGetItemPlayerName( gridlist, row, 1 ) )
		end
	end
end

function guiGridListSetItemPlayerName( gridlist, row, col, name )
	local bHideColorCodes = guiCheckBoxGetSelected ( aTab1.HideColorCodes )
	guiGridListSetItemText( gridlist, row, col, bHideColorCodes and removeColorCoding(name) or name, false, false )
	guiGridListSetItemData( gridlist, row, col, name )
end

function guiGridListGetItemPlayerName( gridlist, row, col )
	return guiGridListGetItemData( gridlist, row, col ) or guiGridListGetItemText( gridlist, row, col )
end

-- remove color coding from string
function removeColorCoding( name )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end

-- anon admin
function isAnonAdmin()
	return getElementData( localPlayer, "AnonAdmin" ) == true
end

function setAnonAdmin( bOn )
	guiCheckBoxSetSelected ( aTab1.AnonAdmin, bOn )
	setElementData( localPlayer, "AnonAdmin", bOn )
end

function loadFlagImage( guiStaticImage, countryCode )
	if countryCode then
		local flagFilename = "client\\images\\flags\\"..tostring ( countryCode )..".png"
		if getVersion().sortable and getVersion().sortable > "1.1.0" then
			-- 1.1
			if fileExists( flagFilename ) then
				if guiStaticImageLoadImage ( guiStaticImage, flagFilename ) then
					return
				end
			end
		else
			-- 1.0
			guiStaticImageLoadImage ( guiStaticImage, "client\\images\\empty.png" )
			guiStaticImageLoadImage ( guiStaticImage, flagFilename )
			return
		end
	end
	guiStaticImageLoadImage ( guiStaticImage, "client\\images\\empty.png" )
end