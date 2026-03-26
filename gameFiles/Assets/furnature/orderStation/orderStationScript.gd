extends FurnatureBase

var type: String = "isInteractable"

@export var ticket : Panel

func _ready() -> void:
	super._ready()

func interaction(_player) -> void:
	if ticket.hasOrder:
		return
	
	# Random base
	var i = randi_range(0, TeaResources.bases.size() - 1)
	ticket.drinkBase = TeaResources.bases[i]
	
	# Random number of extras (0 to 4)
	var num_extras = randi_range(0, 4)
	
	# Clear all extra labels first
	for j in range(4):
		ticket.drinkExtras[j] = "Empty"
	
	# Add random extras
	for j in range(num_extras):
		var t = randi_range(0, TeaResources.extras.size() - 1)
		ticket.drinkExtras[j] = TeaResources.extras[t]
	
	ticket.updateTicket()
	
	ticket.visible = true
	ticket.hasOrder = true
