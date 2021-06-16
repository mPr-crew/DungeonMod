local researchWorldBossPing = table.deepcopy(data.raw["technology"]["military-3"])


researchWorldBossPing.name = "researchWorldBossPing"
researchWorldBossPing.prerequisites = {"military-3"}
researchWorldBossPing.effects = {{ 
  type = "unlock-recipe",
  recipe = "radar"}}

data:extend({researchWorldBossPing})
