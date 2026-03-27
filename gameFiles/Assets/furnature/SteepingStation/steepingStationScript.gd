extends FurnatureBase

var dish
@onready var placeSpot: Marker3D = $placeMarker
var type: String = "isNotInteractable"
@export var ui: Panel

@export var stationActive: bool = false
@export_enum("lvl1","lvl2","lvl3","lvl4") var currentLevel: String

var lvl1List: Array[String] = [
	"green",
	"black",]

var lvl2List: Array[String] = [
	"oolong",
	"white",]

var lvl3List: Array[String] = [
	"yellow",
	"dark",]

var lvl4List: Array[String] = [
	"jasmine",
	"earlGrey",
	"ginseng",
	"chrysanthemum",]

func _ready() -> void:
	super._ready()
	
	ui.station = self
	
	if !stationActive:
		return
	else:
		type = "isInteractable"
	
	upgradeStation(currentLevel)

func upgradeStation(lvl):
	print(TeaResources.bases)
	print(currentLevel)
	match lvl:
		"lvl1":
			TeaResources.bases.append_array(lvl1List)
			print(TeaResources.bases)
		"lvl2":
			TeaResources.bases.append_array(lvl1List)
			TeaResources.bases.append_array(lvl2List)
			print(TeaResources.bases)
		"lvl3":
			TeaResources.bases.append_array(lvl1List)
			TeaResources.bases.append_array(lvl2List)
			TeaResources.bases.append_array(lvl3List)
			print(TeaResources.bases)
		"lvl4":
			TeaResources.bases.append_array(lvl1List)
			TeaResources.bases.append_array(lvl2List)
			TeaResources.bases.append_array(lvl3List)
			TeaResources.bases.append_array(lvl4List)
			print(TeaResources.bases)

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

func steep(teatype, color):
	if dish != null:
		if dish.base == "water" and dish.temperature == "hot":
			dish.base = teatype
			dish.liquid = color
