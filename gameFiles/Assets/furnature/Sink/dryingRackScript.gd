extends FurnatureBase

@export var dishScene: PackedScene
var dish: Array[Node3D] = []
var maxDishes = 30
var placeSpot: Array[Marker3D] = []
var type: String = "isDryingRack"

func _ready() -> void:
	super._ready()
	for marker in $placeMarkers.get_children():
		if marker is Marker3D:
			placeSpot.append(marker)
	if dishScene != null:
		for i in range(maxDishes):
			var newDish = dishScene.instantiate()
			add_child(newDish)
			newDish.global_position = placeSpot[i].global_position
			dish.append(newDish)

func placeDish(incomingDish: Node3D, washingBasin) -> void:
	if dish.size() >= maxDishes:
		return
	if !incomingDish.base == "Empty" or incomingDish.isDirty:
		return
	dish.append(incomingDish)
	incomingDish.reparent(self)
	incomingDish.global_position = placeSpot[dish.size() - 1].global_position
	washingBasin.dish = null
