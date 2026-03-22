extends FurnatureBase

var type: String = "isInteractable"

func interaction(player):
	if player.dishHolding == null:
		return
	var dish = player.dishHolding
	if dish.type == "isCup" and "base" in dish and dish.base == "Empty":
		if !dish.isDirty:
			dish.temperature = "hot"
			dish.fill("water")
