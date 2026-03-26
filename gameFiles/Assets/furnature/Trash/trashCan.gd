extends FurnatureBase

var type: String = "isInteractable"

func interaction(player):
	if player.dishHolding == null:
		return
	var dish = player.dishHolding
	if dish.type == "isCup":
		if dish.base == "Empty":
			return
		
		if dish.base != "water":
			dish.isDirty = true
		dish.temperature = "warm"
		dish.empty()
