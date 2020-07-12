----------- Authors: Morow
----------- Github:  https://github.com/Morow73
----------- No Sale !!! 
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local name = ''
local exit = ''
local label = ''
local inside = ''
local outside = ''
local ipl = ''
local isRoom = ''
local roommenu = ''
local price = ''
local entering = ''
local entrer = ''
local isSingle = ''
local garage = ''
local price = 0 

local debug = false -- debug mode

local zones = { 
['AIRP'] = "Los Santos International Airport",
['ALAMO'] = "Alamo Sea", 
['ALTA'] = "Alta", 
['ARMYB'] = "Fort Zancudo", 
['BANHAMC'] = "Banham Canyon Dr", 
['BANNING'] = "Banning", 
['BEACH'] = "Vespucci Beach", 
['BHAMCA'] = "Banham Canyon", 
['BRADP'] = "Braddock Pass", 
['BRADT'] = "Braddock Tunnel", 
['BURTON'] = "Burton", 
['CALAFB'] = "Calafia Bridge", 
['CANNY'] = "Raton Canyon", 
['CCREAK'] = "Cassidy Creek", 
['CHAMH'] = "Chamberlain Hills", 
['CHIL'] = "Vinewood Hills", 
['CHU'] = "Chumash", 
['CMSW'] = "Chiliad Mountain State Wilderness", 
['CYPRE'] = "Cypress Flats", 
['DAVIS'] = "Davis", 
['DELBE'] = "Del Perro Beach", 
['DELPE'] = "Del Perro", 
['DELSOL'] = "La Puerta", 
['DESRT'] = "Grand Senora Desert", 
['DOWNT'] = "Downtown", 
['DTVINE'] = "Downtown Vinewood", 
['EAST_V'] = "East Vinewood", 
['EBURO'] = "El Burro Heights", 
['ELGORL'] = "El Gordo Lighthouse", 
['ELYSIAN'] = "Elysian Island", 
['GALFISH'] = "Galilee", 
['GOLF'] = "GWC and Golfing Society", 
['GRAPES'] = "Grapeseed", 
['GREATC'] = "Great Chaparral", 
['HARMO'] = "Harmony", 
['HAWICK'] = "Hawick", 
['HORS'] = "Vinewood Racetrack", 
['HUMLAB'] = "Humane Labs and Research", 
['JAIL'] = "Bolingbroke Penitentiary", 
['KOREAT'] = "Little Seoul", 
['LACT'] = "Land Act Reservoir", 
['LAGO'] = "Lago Zancudo", 
['LDAM'] = "Land Act Dam", 
['LEGSQU'] = "Legion Square", 
['LMESA'] = "La Mesa", 
['LOSPUER'] = "La Puerta", 
['MIRR'] = "Mirror Park", 
['MORN'] = "Morningwood", 
['MOVIE'] = "Richards Majestic", 
['MTCHIL'] = "Mount Chiliad", 
['MTGORDO'] = "Mount Gordo", 
['MTJOSE'] = "Mount Josiah", 
['MURRI'] = "Murrieta Heights", 
['NCHU'] = "North Chumash", 
['NOOSE'] = "N.O.O.S.E", 
['OCEANA'] = "Pacific Ocean", 
['PALCOV'] = "Paleto Cove", 
['PALETO'] = "Paleto Bay", 
['PALFOR'] = "Paleto Forest", 
['PALHIGH'] = "Palomino Highlands", 
['PALMPOW'] = "Palmer-Taylor Power Station", 
['PBLUFF'] = "Pacific Bluffs", 
['PBOX'] = "Pillbox Hill", 
['PROCOB'] = "Procopio Beach", 
['RANCHO'] = "Rancho", 
['RGLEN'] = "Richman Glen", 
['RICHM'] = "Richman", 
['ROCKF'] = "Rockford Hills", 
['RTRAK'] = "Redwood Lights Track", 
['SANAND'] = "San Andreas", 
['SANCHIA'] = "San Chianski Mountain Range", 
['SANDY'] = "Sandy Shores", 
['SKID'] = "Mission Row", 
['SLAB'] = "Stab City", 
['STAD'] = "Maze Bank Arena", 
['STRAW'] = "Strawberry", 
['TATAMO'] = "Tataviam Mountains", 
['TERMINA'] = "Terminal", 
['TEXTI'] = "Textile City", 
['TONGVAH'] = "Tongva Hills", 
['TONGVAV'] = "Tongva Valley", 
['VCANA'] = "Vespucci Canals", 
['VESP'] = "Vespucci", 
['VINE'] = "Vinewood",
['WINDF'] = "Ron Alternates Wind Farm", 
['WVINE'] = "West Vinewood",
['ZANCUDO'] = "Zancudo River",
['ZP_ORT'] = "Port of South Los Santos", 
['ZQ_UAR'] = "Davis Quartz" 
}


Citizen.CreateThread(function()

	WarMenu.CreateMenu('Proprieter', '~w~Last Dream')
    WarMenu.SetMenuBackgroundColor("Proprieter", 0, 0, 0, 200)
	WarMenu.SetTitleBackgroundColor("Proprieter", 3, 86, 241, 200)
	WarMenu.SetSubTitle("Proprieter", "~w~CrÉation de propriete by Morow")

    local checkbox = true
	local currentItemIndex = 1
    local selectedItemIndex = 1

	local items = { "Low", "Middle", "Modern", "High", "Luxe", "Motel", "Entrepot (grand)", "Entrepot (moyen)", "Entrepot (petit)" , "Retour"}
    local itemsCount = #items


	while true do

		if WarMenu.IsMenuOpened('Proprieter') then

			local pos = GetEntityCoords(PlayerPedId())
			local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	        local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
			
			if WarMenu.MenuButton('Placer une entrée', 'Proprieter') then
				local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}                          
				local Out = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z+2, 4)}
				
				entering = json.encode(PlayerCoord)
				outside  = json.encode(Out)

                PedPosition = pos
                DrawMarker(1, pos.x, pos.y, pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.5, 2.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)  
                ESX.ShowNotification('position de la porte : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z.. '~w~, Adresse : ~b~'..current_zone.. '')
                ESX.ShowNotification('position de la sortie : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z..'')
	          
            elseif WarMenu.MenuButton('Placer un garage ~g~(non obligatoire)', 'Proprieter') then
				local GaragePos = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}     
              	garage = json.encode(GaragePos)

                DrawMarker(1, pos.x, pos.y, pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.5, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)      
                ESX.ShowNotification('position du garage :~b~ '..GaragePos.x..' , '..GaragePos.y..' , '..GaragePos.z..  '')

            elseif WarMenu.CheckBox('Visiter | Apercu', checkbox) then
            	
				checkbox = not checkbox

				ESX.ShowNotification('~g~On~w~ pour vous rendre sur place, ~r~Off~w~ pour avoir un appercu')

		    elseif WarMenu.ComboBox('Interieur', items, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
                
		    	currentItemIndex = currentIndex
				selectedItemIndex = selectedIndex

				if itemsCount > 1 and isCurrent then
					selectedItem = '← '..tostring(items)..' →'
				end

				end) then

		    	if selectedItemIndex == 1 then 

		    		if checkbox == false then 
                        Cam('Low')
					else
						ipl = '[]'
						inside = '{"x":265.307,"y":-1002.802,"z":-101.008}'
						exit = '{"x":266.0773,"y":-1007.3900,"z":-101.008}'
					    isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), 265.6031, -1002.9244, -99.0086)		
					end		
                     
				elseif selectedItemIndex == 2 then 
					
		    		if checkbox == false then 
                        Cam('Middle')
					else
						ipl = '[]'
						inside = '{"x":-612.16,"y":59.06,"z":97.2}'
						exit = '{"x":-603.4308,"y":58.9184,"z":97.2001}'
					    isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), -616.8566, 59.3575, 98.2000)		
					end	

				elseif selectedItemIndex == 3 then 

		    		if checkbox == false then 
		    			Cam('Modern')
					else
						ipl = '["apa_v_mp_h_01_a"]'
						inside = '{"x":-785.13,"y":315.79,"z":187.91}'
						exit = '{"x":-786.87,"y":315.7497,"z":186.91}'
						isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), -788.3881, 320.2430, 187.3132)		
					end			

		    	elseif selectedItemIndex == 4 then 

		    		if checkbox == false then 
		    			Cam('High')
					else
						ipl = '[]'
						inside = '{"x":-1459.17,"y":-520.58,"z":54.929}'
						exit = '{"x":-1451.6394,"y":-523.5562,"z":55.9290}'
						isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), -1459.1700, -520.5855, 56.9247)		
					end		

		        elseif selectedItemIndex == 5 then 

		    	   if checkbox == false then 
		    	   	   Cam('Luxe')
					else
						ipl = '[]'
						inside = '{"x":-680.6088,"y":590.5321,"z":145.39}'
						exit = '{"x":-681.6273,"y":591.9663,"z":144.3930}'				
						isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), -674.4503, 595.6156, 145.3796)		
					end		

		    	elseif selectedItemIndex == 6 then 

		    		
		    	   if checkbox == false then 
		    	   	    Cam('Motel')   
					else
						ipl = '["hei_hw1_blimp_interior_v_motel_mp_milo_"]'
						inside = '{"x":151.45,"y":-1007.57,"z":-98.9999}'
						exit = '{"x":151.3258,"y":-1007.7642,"z":-100.0000}'
						isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), 151.0994, -1007.8073, -98.9999)		
					end		

		        elseif selectedItemIndex == 7 then 

		    	    if checkbox == false then 
		    	    	Cam('Entrepot1')
					else
						ipl = '[]'
						inside = '{"x":1026.5056,"y":-3099.8320,"z":-38.9998}'
						exit   = '{"x":998.1795"y":-3091.9169,"z":-39.9999}'
						isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), 1026.8707, -3099.8710, -38.9998)		
					end	

		        elseif selectedItemIndex == 8 then 

		    	    if checkbox == false then 
                       Cam('Entrepot2')
					else
						ipl = '[]'
						inside = '{"x":1048.5067,"y":-3097.0817,"z":-38.9999}'
						exit   = '{"x":1072.5505,"y":-3102.5522,"z":-39.9999}'
						isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), 1072.8447, -3100.0390, -38.9999)		
					end	

		        elseif selectedItemIndex == 9 then 

		    	    if checkbox == false then 
                      Cam('Entrepot3')
					else
						ipl = '[]'
						inside = '{"x":1088.1834,"y":-3099.3547,"z":-38.9999}'
						exit   = '{"x":1104.6102,"y":-3099.4333,"z":-39.9999}'
						isSingle = 1
					    isRoom = 1
					    isGateway = 0
						SetEntityCoords(GetPlayerPed(-1), 1104.7231, -3100.0690, -38.9999)		
					end		
		        elseif selectedItemIndex == 10 then -- retour                
                   Destroy()                 
		    	end		 
    	    

		    elseif WarMenu.MenuButton('Placer le coffre', 'Proprieter') then

				local CoffreCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 
				roommenu = json.encode(CoffreCoord)
                ESX.ShowNotification('position du coffre :~b~'..CoffreCoord.x..' , '..CoffreCoord.y..' , '..CoffreCoord.z.. '')
                DrawMarker(1, pos.x, pos.y, pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.5, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false) 

            elseif WarMenu.MenuButton('Entrer un nom', 'Proprieter') then 
                name  =  OpenKeyboard('name', 'Entrer un nom sans éspace !')
            elseif WarMenu.MenuButton('Entrer un label', 'Proprieter') then
                label = OpenKeyboard('label', 'Entrer un label !')
		    elseif WarMenu.MenuButton('Prix', 'Proprieter') then
		        price = OpenKeyboard('price', 'Entrer un prix')
		    elseif WarMenu.MenuButton('Annuler', 'Proprieter') then

                if PedPosition ~= nil then
		    	   SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)
		    	end  

		    	Citizen.Wait(50)
		    	WarMenu.CloseMenu('Proprieter')
		    	ESX.ShowNotification('Création de propriété annulé')
  
		    elseif WarMenu.MenuButton('Valider', 'Proprieter') then

                if tonumber(price) == nil or tonumber(price) == 0 then
		            ESX.ShowNotification('~r~Vous n\'avez aucun prix assigné !')
		        else 
		        	if name == '' then 
		        		ESX.ShowNotification('~r~Vous n\'avez aucun nom assigné !')
		        	else 	
		    	       TriggerServerEvent('mrw_prop:Save', name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, garage, price)
		    	   
			    	   Citizen.Wait(15)
			    	   SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)
			    	end
		    	end   
		    	
                if debug then 
			    	print('Name'..name)
			    	print('ipl' ..ipl)
			    	print('label' ..label)
			    	print('entering' ..entering)
			    	print('inside' ..inside)
			    	print('roommenu' ..roommenu)
			    	print('exit' ..exit)
					print('outside' ..outside)
					print('price'..price)
					if garage ~= nil then 
						print('garage'..garage)
					end	   
		    	end                	
			end

			WarMenu.Display()	
		end
		Citizen.Wait(1)
	end		
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlPressed(0, 168) then
		   WarMenu.OpenMenu('Proprieter')
	    end
	end
end)

local function noSpace(str)
   local normalisedString = string.gsub(str, "%s+", "")
   return normalisedString
end

function OpenKeyboard(type, labelText)
    
    AddTextEntry('FMMC_KEY_TIP1', labelText)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 25)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		if type == "name" then 
			ESX.ShowNotification("Nom assigné : ~b~"..noSpace(result))
		    return noSpace(result) 
		elseif type == "label" then 
			ESX.ShowNotification("Label assigné : ~b~"..result)
			return result
		else 
		    if tonumber(result) == nil then 
		       ESX.ShowNotification("Vous devez entré un ~r~prix")
		       return
		    end	
		    ESX.ShowNotification("Prix assigné : ~b~"..tonumber(result).."~w~ $")
		    return tonumber(result)
		end
	else
		Citizen.Wait(500)
		blockinput = false 
		return nil
	end
end


function Cam(type)
	local ped = GetPlayerPed(-1)
	if type == 'Low' then 
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(265.6078, -995.8491, -99.0086, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 265.9317, -999.4464, -99.0086)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 87.69)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Middle' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-616.8566, 59.3575, 98.2000, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -616.8566, 59.3575, 98.2000)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 195.59)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)	
	elseif type == 'Modern' then 
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-788.3881, 320.2430, 187.3132, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -788.3881, 320.2430, 187.3132)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 355.81)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'High' then 
	    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-1459.1700, -520.5855, 56.9247, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -1459.1700, -520.5855, 56.9247)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 150.2664)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)	
    elseif type == 'Luxe' then 
	    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-674.4503, 595.6156, 145.3796, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -674.4503, 595.6156, 145.3796)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 195.45)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)	
	elseif type == 'Motel' then 
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(151.0994, -1007.8073, -98.9999, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 151.0994, -1007.8073, -98.9999)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 337.79)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)	
	elseif type == 'Entrepot1' then 
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(1026.8707, -3099.8710, -38.9998, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 1026.8707, -3099.8710, -38.9998)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 88.76)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Entrepot2' then 
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(1072.8447, -3100.0390, -38.9999, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 1072.8447, -3100.0390, -38.9999)
		SetCamActive(cam,  true)
		SetCamRot(cam, 0.0, 0.0, 91.85)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)	
	elseif type == 'Entrepot3'	then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(1104.7231, -3100.0690, -38.9999, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 1104.7231, -3100.0690, -38.9999)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 85.68)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	end	
end

function Destroy()
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
	SetCamActive(cam,  false)	
	FreezeEntityPosition(GetPlayerPed(-1), false)
	RenderScriptCams(false,  false,  0,  false,  false)
    SetFocusEntity(PlayerPedId())
	print('retour')
end
