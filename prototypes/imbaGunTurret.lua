local imbaGunTurret = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

imbaGunTurret.name = "imbaGunTurret"
imbaGunTurret.automated_ammo_count = 99999
data:extend({imbaGunTurret})
