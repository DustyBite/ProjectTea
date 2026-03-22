extends FurnatureBase

@export var dishScene: PackedScene
var dish
@onready var placeSpot: Marker3D = $placeMarker
var isTable: bool = true

func _ready() -> void:
	super._ready()
	
	if dishScene != null:
		dish = dishScene.instantiate()
		add_child(dish)
		dish.global_position = placeSpot.global_position

func placeDish(incomingDish: Node3D) -> void:
	dish = incomingDish
	dish.reparent(self)
	dish.global_position = placeSpot.global_position
