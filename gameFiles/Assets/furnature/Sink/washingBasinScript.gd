extends FurnatureBase

var dish: Node3D
@onready var placeSpot: Marker3D = $placeMarker
var type: String = "isInteractable"
@export var dirtyBasin: StaticBody3D
@export var dryingrack: StaticBody3D

func interaction(_player) -> void:
	if dish != null:
		return
	grabDirtyDish()

func grabDirtyDish():
	if dirtyBasin.dish.is_empty():
		return
	dish = dirtyBasin.dish.back()
	dirtyBasin.dish.erase(dish)
	dish.reparent(placeSpot)
	dish.position = Vector3.ZERO
	
	print("Grabbed Dirty Dish")
	await get_tree().create_timer(1.0).timeout
	cleanDish()

func cleanDish():
	match dish.type:
		"isCup":
			dish.isDirty = false
			dish.base = "Empty"
			dish.mixins[0] = "Empty"
			dish.mixins[1] = "Empty"
			dish.mixins[2] = "Empty"
			dish.temperature = "warm"
	
	print("Cleaning Dirty Dish")
	await get_tree().create_timer(1.0).timeout
	placeCleanDish()

func placeCleanDish():
	if dryingrack.dish is Array:
		dryingrack.placeDish(dish, self)
	
	print("Place Clean Dish")

#func placeDish() -> void:
	#if dishHolding == null:
		#return
	#
	#if furniture.dish is Array:
		#furniture.placeDish(dishHolding, self)
	#else:
		#if furniture.dish != null:
			#return
		#furniture.dish = dishHolding
		#dishHolding.reparent(furniture)
		#dishHolding.global_position = furniture.placeSpot.global_position
		#dishHolding = null
