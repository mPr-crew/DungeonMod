data:extend(
{
  {
    name ="worldBoss1KillAchievement",
    type = "kill-achievement",
    localised_description= "You killed the first World Boss. That's like beating Kindergarden to start primary school.",
    localised_name = "Like a Baus",
  
    icon = "__base__/graphics/achievement/so-long-and-thanks-for-all-the-fish.png",
    icon_size = 128,
    allowed_without_fight = true,

    amount = 1,
    personally = false,
    in_vehicle = false,
    to_kill = "worldBoss1"
    
  },

  ----- SCRIPTED ACHIEVEMENTS (GRANT WITH player.unlock_achievement)
  {
    name ="enterADungeonAchievement1",
    type ="achievement", -- THIS IS A MUST VALUE FOR SCRIPTED ACHIEVEMENTS
    localised_description= "You entered a Dungeon. Don't get hyped. It's not that great.",
    localised_name = "Dungeon Minion",
    
    icon = "__base__/graphics/achievement/so-long-and-thanks-for-all-the-fish.png",
    icon_size = 128,
    allowed_without_fight = true
  }
  
})