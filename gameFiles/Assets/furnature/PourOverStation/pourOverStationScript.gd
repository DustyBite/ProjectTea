extends FurnatureBase

var dish
@onready var placeSpot: Marker3D = $placeMarker
var type: String = "isInteractable"
@export var ui: Panel

func _ready() -> void:
	super._ready()
	
	ui.station = self

func interaction(player) -> void:
	player.isStuck = !player.isStuck
	
	if player.isStuck:
		ui.visible = true
		
		if player.dishHolding != null:
			dish = player.dishHolding
			dish.reparent(self)
			dish.global_position = placeSpot.global_position
	elif !player.isStuck:
		ui.visible = false
		
		player.grabDish()

func pourOver(teatype, color):
	if dish != null:
		if dish.base == "water" and dish.temperature == "hot":
			dish.base = teatype
			dish.liquid = color
