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

func mixBase(teatype, color):
	if dish != null:
		if dish.base == "water" and dish.temperature == "hot":
			dish.base = teatype
			dish.liquid = color

func mixAdd(additive):
	if dish != null:
		if dish.base != "Empty":
			var i = 0
			while i < dish.mixins.size() and dish.mixins[i] != "Empty":
				i += 1
			
			if i < dish.mixins.size():
				dish.mixins[i] = additive

func mixAddCol(additive, mixColor, strength):
	if dish != null:
		if dish.base != "Empty":
			var i = 0
			while i < dish.mixins.size() and dish.mixins[i] != "Empty":
				i += 1
			
			if i < dish.mixins.size():
				dish.mixins[i] = additive
				var finalColor = dish.liquid.lerp(mixColor, strength)
				dish.liquid = finalColor
