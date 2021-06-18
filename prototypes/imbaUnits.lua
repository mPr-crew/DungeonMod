require ("__base__.prototypes.entity.biter-animations")
local sounds = require ("__base__.prototypes.entity.sounds")
local imbaSmallBiter = table.deepcopy(data.raw["unit"]["small-biter"])


imbaSmallBiter.name = "imbaSmallBiter"
imbaSmallBiter.movement_speed = 0.075
imbaSmallBiter.max_health = 40
imbaSmallBiter.healing_per_tick = 0.02
imbaSmallBiter.collision_box = {{-0.01, -00.1}, {0.01, 00.1}}
imbaSmallBiter.resistances = {
  {
    type = "physical",
    decrease = 0,
    percent = 10
  },
  {
    type = "explosion",
    decrease = 0,
    percent = 80
  },
  {
    type = "acid",
    decrease = 0,
    percent = 10
  },
  {
    type = "fire",
    decrease = 0,
    percent = 0
  }
}
data:extend({imbaSmallBiter})

local imbaSmallBiter_fast =  table.deepcopy(data.raw["unit"]["imbaSmallBiter"])
imbaSmallBiter_fast.name = "imbaSmallBiter_fast"
imbaSmallBiter_fast.movement_speed = 0.2
data:extend({imbaSmallBiter_fast})

local worldBoss1 = table.deepcopy(data.raw["unit"]["behemoth-biter"])
local worldBoss1Scale = 3
local worldBoss1tint1 = {r=1, g=1, b=1, a=1}
local worldBoss1tint2 = {r=0, g=0, b=0, a=1}

worldBoss1.name = "worldBoss1"
worldBoss1.max_health = 100000
worldBoss1.healing_per_tick = 1
worldBoss1.emissions_per_second = 1
worldBoss1.call_for_help_radius = 1000
worldBoss1.scale = 100
worldBoss1.attack_parameters =
    {
      type = "projectile",
      range = 0.5,
      cooldown = 35,
      cooldown_deviation = 0.15,
      ammo_type = make_unit_melee_ammo_type(70),
      sound = sounds.biter_roars(0.35),
      animation = biterattackanimation(worldBoss1Scale, worldBoss1tint1, worldBoss1tint2),
      range_mode = "bounding-box-to-bounding-box"
    }
worldBoss1.run_animation = biterrunanimation(worldBoss1Scale, worldBoss1tint1, worldBoss1tint2)
worldBoss1.collision_box = {{-5, -5}, {5, 5}}
worldBoss1.collision_mask = {}
worldBoss1.selection_box = {{-5, -5}, {5, 5}}
worldBoss1.water_reflection = biter_water_reflection(3)
worldBoss1.ai_controllable = false
worldBoss1.allow_try_return_to_spawner = false
worldBoss1.allow_destroy_when_commands_fail = false
data:extend({worldBoss1})