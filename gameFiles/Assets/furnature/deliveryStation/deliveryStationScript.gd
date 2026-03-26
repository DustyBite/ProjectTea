extends FurnatureBase

var dish
@onready var placeSpot: Marker3D = $placeMarker
var type: String = "isTable"

@export var ticket : Panel

func _ready() -> void:
	super._ready()

func placeDish(incomingDish: Node3D) -> void:
	dish = incomingDish
	dish.reparent(self)
	dish.global_position = placeSpot.global_position
	
	if dish.base != ticket.drinkBase:
		print("Wrong Drink")
		return
	
	var i = 4
	var j = 4
	while j > 0:
		j -= 1
		while i > 0:
			i -= 1
			print(dish.mixins[j])
			print(ticket.drinkExtras[i])
			if dish.mixins[j] != ticket.drinkExtras[i]:
				print("Wrong Drink")
				return
			elif dish.mixins[j] == ticket.drinkExtras[i]:
				i = 0
	
	dish.empty()
	dish.isDirty = true
	
	ticket.visible = false
	ticket.clearTicket()
