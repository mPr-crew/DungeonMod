local event = require("__flib__.event")
local gui = require("__flib__.gui-beta")
local migration = require("__flib__.migration")
event.on_init(function()
	math.randomseed(1)-- change to os.time() later, now use testing seed --needs to be run once before using math.random
	for i, player in pairs(game.players) do
		for i = 1, 100,1 do
			player.surface.create_entity{name="dungeonEntrance", position={math.random, math.random}, force="neutral"} --how is the map built up? max coordinates??
		end
		return
	end
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

script.on_event("my-custom-input", function(event)
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
	game.print("Player No. " .. e.player_index .. " mined " .. e.entity.name)
end)