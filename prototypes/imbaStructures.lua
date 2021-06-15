local imbaGunTurret = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
local imbaStoneWall = table.deepcopy(data.raw["wall"]["stone-wall"])

imbaGunTurret.name = "imbaGunTurret"
imbaGunTurret.automated_ammo_count = 99999
data:extend({imbaGunTurret})

imbaStoneWall.name = "imbaStoneWall"
imbaStoneWall.resistances = {
  {
    type = "physical",
    decrease = 0,
    percent = 100
  },
  {
    type = "explosion",
    decrease = 0,
    percent = 100
  },
  {
    type = "acid",
    decrease = 0,
    percent = 100
  },
  {
    type = "fire",
    decrease = 0,
    percent = 100
  }
}
data:extend({imbaStoneWall})

