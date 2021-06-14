local event = require("__flib__.event")
local gui = require("__flib__.gui-beta")
local migration = require("__flib__.migration")
last_position = {}
last_position_x={}
last_position_y={}


event.on_init(function()
	game.surfaces["nauvis"].create_entity{name="dungeonEntrance", position={1, 1}, force="neutral"} --how is the map built up? max coordinates??
	for i = 0, 100, 1 do
		game.surfaces["nauvis"].create_entity{name="dungeonEntrance", position={math.random(-1000, 1000),math.random(-1000, 1000)}, force="neutral"} --how is the map built up? max coordinates??
	end
	global.dungeonSurface = game.create_surface("dungeon")
  	global.dungeonSurface.daytime = 0.5
  	global.dungeonSurface.freeze_daytime = true
	global.dungeonSurface.solar_power_multiplier = 0
	global.dungeonSurface.generate_with_lab_tiles = true
	for i = -8, 100, 1 do
		global.dungeonSurface.create_entity{name = "cliff", position = {i, -10}, force ="neutral", direction = defines.direction.north}
		global.dungeonSurface.create_entity{name = "cliff", position = {i, 10}, force ="neutral", direction = defines.direction.north}
	end
		global.dungeonSurface.create_entity{name = "cliff", position = {-10, -10}, force ="neutral", direction = defines.direction.northwest}
		global.dungeonSurface.create_entity{name = "cliff", position = {-10, 10}, force ="neutral", direction = defines.direction.northeast}
	for i = -10, 10, 1 do 
		global.dungeonSurface.create_entity{name = "cliff", position = {-10, i}, force ="neutral", direction = defines.direction.southwest}
	end

	--TESTCLIFFS
	global.dungeonSurface.create_entity{name = "cliff", position = {20, 20}, force ="neutral", direction = defines.direction.north}
	global.dungeonSurface.create_entity{name = "cliff", position = {30, 20}, force ="neutral", direction = defines.direction.northeast}
	global.dungeonSurface.create_entity{name = "cliff", position = {30, 30}, force ="neutral", direction = defines.direction.east}
	global.dungeonSurface.create_entity{name = "cliff", position = {30, 40}, force ="neutral", direction = defines.direction.southeast}
	global.dungeonSurface.create_entity{name = "cliff", position = {20, 40}, force ="neutral", direction = defines.direction.south}
	global.dungeonSurface.create_entity{name = "cliff", position = {10, 40}, force ="neutral", direction = defines.direction.southwest}
	global.dungeonSurface.create_entity{name = "cliff", position = {10, 30}, force ="neutral", direction = defines.direction.west}
	global.dungeonSurface.create_entity{name = "cliff", position = {10, 20}, force ="neutral", direction = defines.direction.northwest}

	--global.dungeonSurface.map_gen_settings = ??
end)
event.on_tick(function()
	for i, thisAccumulator in pairs(game.surfaces["nauvis"].find_entities_filtered({type = "accumulator"})) do
		--game.print(thisAccumulator.energy)
		if thisAccumulator.energy /50000 < 20 then -- 5.000.000 is max energy of accumulator * 100 -> %
			game.print("WO STROM???",{r=1, g=0, b=0, a=1})
		end
	return
	end
end)

script.on_event("my-custom-input", function(event) -- Hotkey K for creating dungeon entrance near player to test
	game.print("Create Dungeon entrance at player position")
	for i,player in pairs(game.players) do
		local xPlus = math.random(-50,50)
		local yPlus = math.random(-50,50)
		while (xPlus < 2 and yPlus < 2) and (xPlus > -2 and yPlus > -2) do
			local xPlus = math.random(-50,50)
			local yPlus = math.random(-50,50)
		end
		player.surface.create_entity{name="dungeonEntrance", position={player.position.x+xPlus, player.position.y+yPlus}, force="neutral"} 
	end
end)

event.on_pre_player_mined_item(function(e)
	
	local player = game.players[e.player_index]
	if e.entity.name == "dungeonEntrance" then
		last_position[e.player_index] = player.position
		game.print(player.name .. " is entering dungeon.")
		
		player.teleport({0,0},"dungeon")
		player.surface.create_entity{name="dungeonExit", position={player.position.x-2, player.position.y-2}, force="neutral"} 
		local inv = player.get_main_inventory()
		inv.remove({name="dungeonEntranceCard", count=1})
		player.surface.create_unit_group({position = {0,0},force="enemy"})
		player.surface.build_enemy_base({0,0}, 10, "enemy")
		local gunTurret = player.surface.create_entity{name = "imbaGunTurret", position = {15, 0}, direction = defines.direction.west}
		gunTurret.get_inventory(1).insert({name="firearm-magazine", count = 9999})

		--player.surface.create_entity{name = "inserter", position = {6, 0} , direction = defines.direction.east}
		--player.surface.create_entity{name = "steel-chest", position = {7, 0} , direction = defines.direction.west}
		
	elseif e.entity.name == "dungeonExit" then
		game.print(player.name .. " is exiting dungeon.")
		player.teleport(last_position[e.player_index],"nauvis")
		local inv = player.get_main_inventory()
		inv.remove({name="dungeonEntranceCard", count=1})
	else
	game.print(player.name .. " mined " .. e.entity.name)
	end
	
end)