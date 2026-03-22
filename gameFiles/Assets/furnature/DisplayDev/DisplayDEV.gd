extends FurnatureBase

var dish
@onready var placeSpot: Marker3D = $placeMarker
var type: String = "isTable"

func _process(_delta: float) -> void:
	if dish != null:
		if  dish.type == "isCup":
			if dish.base != "Empty":
				print("Drink Base: " + dish.base + ", Mixed with: " + dish.mixins[0] + ", " + dish.mixins[1] + ", " + dish.mixins[2] + ", Temperature:" + dish.temperature)

func placeDish(incomingDish: Node3D) -> void:
	dish = incomingDish
	dish.reparent(self)
	dish.global_position = placeSpot.global_position
