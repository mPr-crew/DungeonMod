
local event = require("__flib__.event")
local gui = require("__flib__.gui-beta")
local migration = require("__flib__.migration")

last_position = {}

event.on_nth_tick(500, function(e)
	--game.print("nth-tick")
	for i, thisAccumulator in pairs(game.surfaces["nauvis"].find_entities_filtered({type = "accumulator"})) do
		-- game.print(thisAccumulator.energy .. " --> [gps=" .. thisAccumulator.position.x .. "," .. thisAccumulator.position.y .. "]")
		if thisAccumulator.energy /50000 < 20 then -- 5.000.000 is max energy of accumulator * 100 -> %
			game.print("WO STROM???",{r=1, g=0, b=0, a=1})
		end
	return
	end
	local actualPollution = game.surfaces["nauvis"].get_total_pollution()
	if actualPollution > 10000 then
		local worldBoss = game.surfaces["nauvis"].create_entity{name="worldBoss1", position={math.random(-1000, 1000),math.random(-1000, 1000)}, force="enemy"} 
		-- worldBoss
	end

end)
event.on_init(function()
	local j = 0
	game.surfaces["nauvis"].create_entity{name="dungeonEntrance", position={1, 1}, force="neutral"} --how is the map built up? max coordinates??
	for i = 0, 100, 1 do
		game.surfaces["nauvis"].create_entity{name="dungeonEntrance", position={math.random(-1000, 1000),math.random(-1000, 1000)}, force="neutral"} --how is the map built up? max coordinates??
	end
	global.dungeonSurface = game.create_surface("dungeon")
  	global.dungeonSurface.daytime = 1
  	global.dungeonSurface.freeze_daytime = true
	global.dungeonSurface.solar_power_multiplier = 0
	global.dungeonSurface.generate_with_lab_tiles = true
	--for i = -8, 100, 4 do
		--global.dungeonSurface.create_entity{name = "cliff", position = {i, -10}, force ="neutral", direction = defines.direction.north}
		--global.dungeonSurface.create_entity{name = "cliff", position = {i, 10}, force ="neutral", direction = defines.direction.north}
	--end
		--global.dungeonSurface.create_entity{name = "cliff", position = {-10, -10}, force ="neutral", direction = defines.direction.northwest}
		--global.dungeonSurface.create_entity{name = "cliff", position = {-10, 10}, force ="neutral", direction = defines.direction.northeast}
	--for i = -10, 10, 4 do 
		--global.dungeonSurface.create_entity{name = "cliff", position = {-10, i}, force ="neutral", direction = defines.direction.southwest}
	--end
	for i = -9, 100, 1 do
		global.dungeonSurface.create_entity{name = "imbaStoneWall", position = {i, -10}, force = "enemy"}
		global.dungeonSurface.create_entity{name = "imbaStoneWall", position = {i, 10}, force = "enemy"}
	end
	for i = -10, 10, 1 do 
		global.dungeonSurface.create_entity{name = "imbaStoneWall", position = {-10, i}, force ="enemy", direction = defines.direction.south}
	end

	--TESTCLIFFS, BIG CLIFFS
	local x = 20
	local y = 20
	global.dungeonSurface.create_entity{name = "cliff", position = {x, y}, force ="neutral", direction = defines.direction.north}
	global.dungeonSurface.create_entity{name = "cliff", position = {x+10, y}, force ="neutral", direction = defines.direction.northeast}
	global.dungeonSurface.create_entity{name = "cliff", position = {x+10, y+10}, force ="neutral", direction = defines.direction.east}
	global.dungeonSurface.create_entity{name = "cliff", position = {x+10, y+20}, force ="neutral", direction = defines.direction.southeast}
	global.dungeonSurface.create_entity{name = "cliff", position = {x, y+20}, force ="neutral", direction = defines.direction.south}
	global.dungeonSurface.create_entity{name = "cliff", position = {x-10, y+20}, force ="neutral", direction = defines.direction.southwest}
	global.dungeonSurface.create_entity{name = "cliff", position = {x-10, y+10}, force ="neutral", direction = defines.direction.west}
	global.dungeonSurface.create_entity{name = "cliff", position = {x-10, y}, force ="neutral", direction = defines.direction.northwest}

	--global.dungeonSurface.map_gen_settings = ??
	
end)


event.on_entity_died(function(e)
	game.print("destroyed something")
	if (e.entity.name =="imbaStoneWall") then
		game.print("destroyed wall")
		global.dungeonSurface.create_entity{name = e.entity.name, position = {e.entity.position.x,e.entity.position.y}, force =e.entity.force,direction= e.entity.direction}
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
		player.surface.create_entity{name="worldBoss1", position={player.position.x+xPlus, player.position.y+yPlus}, force="enemy"} 

	end
end)

event.on_pre_player_mined_item(function(e)
	
	local player = game.players[e.player_index]
	if e.entity.name == "dungeonEntrance" then
		game.print(player.name .. " is entering dungeon.")
		last_position[e.player_index] = player.position
		GiveEnteringPlayerSomeGuns(player)
		player.teleport({0,0},"dungeon")
		player.surface.create_entity{name="dungeonExit", position={player.position.x-3, player.position.y-3}, force="neutral"} 
		local inv = player.get_main_inventory()
		inv.remove({name="dungeonEntranceCard", count=1})
		InsertTurrets(player)
		InsertSmallBiters(player)
		player.unlock_achievement("enterADungeonAchievement1")
		
	elseif e.entity.name == "dungeonExit" then
		game.print(player.name .. " is exiting dungeon.")
		player.teleport(last_position[e.player_index],"nauvis")
		local inv = player.get_main_inventory()
		inv.remove({name="dungeonEntranceCard", count=1})
	else
	game.print(player.name .. " mined " .. e.entity.name)
	end
	
end)
function GiveEnteringPlayerSomeGuns(player)
	player.get_main_inventory().insert({name = "shotgun", count = 1})
	player.get_main_inventory().insert({name = "shotgun-shell", count = 100})
	player.get_main_inventory().insert({name = "rocket-launcher", count = 1})
	player.get_main_inventory().insert({name = "explosive-rocket", count = 100})
end

function InsertTurrets(player)
	local gunTurret = player.surface.create_entity{name = "imbaGunTurret", position = {30, 0}, direction = defines.direction.west, force = "enemy"}
	gunTurret.get_inventory(1).insert({name="firearm-magazine", count = 9999})
end

function InsertSmallBiters(player)
	local imbaSmallBiter = player.surface.create_entity{name = "imbaSmallBiter", position = {35, 0}, direction = defines.direction.west, force = "enemy"}
		for i = 0, 30, 0.5 do
			player.surface.create_entity{name = "imbaSmallBiter", position = {50+i, -1}, direction = defines.direction.west, force = "enemy"}
			player.surface.create_entity{name = "imbaSmallBiter", position = {50+i, 0}, direction = defines.direction.west, force = "enemy"}
			player.surface.create_entity{name = "imbaSmallBiter", position = {50+i, 1}, direction = defines.direction.west, force = "enemy"}
		end
		for i = 0, 30, 0.5 do
			player.surface.create_entity{name = "imbaSmallBiter_fast", position = {80+i, -1}, direction = defines.direction.west, force = "enemy"}
			player.surface.create_entity{name = "imbaSmallBiter_fast", position = {80+i, 0}, direction = defines.direction.west, force = "enemy"}
			player.surface.create_entity{name = "imbaSmallBiter_fast", position = {80+i, 1}, direction = defines.direction.west, force = "enemy"}
		end
end