local dungeonEntrance = table.deepcopy(data.raw["tree"]["dead-grey-trunk"])
local dungeonEntranceCard = table.deepcopy(data.raw["item"]["wood"])
dungeonEntranceCard.name = "dungeonEntranceCard"

dungeonEntrance.name = "dungeonEntrance"
dungeonEntrance.pictures =
{
  filename = "__DungeonMod__/graphics/dungeonEntrance.png",
  priority = "extra-high",
  width = 166,
  height = 122,
  shift = {0.7, -0.2}
}
dungeonEntrance.map_color = {r=1, g=0, b=1, a=1}
dungeonEntrance.flags = {"placeable-neutral"}
dungeonEntrance.minable = {
      mining_particle = "wooden-particle",
      mining_time = 0.55,
      result = dungeonEntranceCard.name,
      count = 1,
      mining_trigger =
      {
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              target_effects = leaf_sound_trigger
            }
          }
        }
      }
    }
dungeonEntrance.remains_when_mined ="dungeonEntrance"
data:extend({dungeonEntrance})