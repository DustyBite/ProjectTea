extends Node

@onready var baseLabel := $base
@onready var extrasLabel: Array[Label] = [$extra1,$extra2,$extra3,$extra4]

var hasOrder : bool = false

var baseTextDefault: String
@onready var extrasLabelText: Array[String] = ["","","",""]

var drinkBase: String = "Empty"
var drinkExtras: Array[String] = ["Empty","Empty","Empty","Empty"]

func _ready() -> void:
	baseTextDefault = baseLabel.text
	var i = 4
	while i > 0:
		i -= 1
		extrasLabelText[i] = extrasLabel[i].text
	
	updateTicket()

func updateTicket():
	baseLabel.text = baseTextDefault + " " + drinkBase
	
	var i = 4
	while i > 0:
		i -= 1
		extrasLabel[i].text = extrasLabelText[i] + " " + drinkExtras[i]

func clearTicket():
	baseLabel.text = baseTextDefault
	
	var i = 4
	while i > 0:
		i -= 1
		extrasLabel[i].text = extrasLabelText[i]
	
	hasOrder = false
