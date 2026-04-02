extends FurnatureBase

var dish
@onready var cupSpot: Marker3D = $cupPos
var type: String = "isNotInteractable"
@export var ui: Panel

@export var stationActive: bool = false
@export_enum("lvl1","lvl2","lvl3","lvl4") var currentLevel: String

@onready var jarPosMarkersNode = $jarPosMarkers
@onready var jarTTM = $jarPos
var jPMArray: Array[Marker3D]
var jarArray: Array[Node3D]
@export var jarScene: PackedScene

@onready var steeper = $steeper
@onready var steeperPos = $steeperPos

var jarColor: Array[Color] = [
	Color(0.65, 0.85, 0.35),
	Color(0.35, 0.18, 0.08),
	Color(0.55, 0.35, 0.18),
	Color(0.95, 0.92, 0.75),
	Color(0.95, 0.75, 0.25),
	Color(0.25, 0.12, 0.05),
	Color(0.80, 0.95, 0.55),
	Color(0.32, 0.20, 0.12),
	Color(0.85, 0.65, 0.30),
	Color(0.98, 0.85, 0.40)]

var teaList: Array[String]

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
			teaList.append_array(lvl1List)
			#print(TeaResources.bases)
		"lvl2":
			teaList.append_array(lvl1List)
			teaList.append_array(lvl2List)
			#print(TeaResources.bases)
		"lvl3":
			teaList.append_array(lvl1List)
			teaList.append_array(lvl2List)
			teaList.append_array(lvl3List)
			#print(TeaResources.bases)
		"lvl4":
			teaList.append_array(lvl1List)
			teaList.append_array(lvl2List)
			teaList.append_array(lvl3List)
			teaList.append_array(lvl4List)
			#print(TeaResources.bases)
	
	TeaResources.bases.append_array(teaList)
	
	setJars()

func setJars():
	for marker in jarPosMarkersNode.get_children():
		jPMArray.append(marker)
	
	jarArray.resize(jPMArray.size())
	print(jarArray)
	
	var i = jPMArray.size()
	while i > 0:
		var jar = jarScene.instantiate()
		add_child(jar)
		jarArray[i-1] = jar
		jar.global_position = jPMArray[i-1].global_position
		jar.updateJar(jarColor[i-1])
		i -= 1

func interaction(player) -> void:
	player.isStuck = !player.isStuck
	
	if player.isStuck:
		ui.visible = true
		
		if player.dishHolding != null:
			dish = player.dishHolding
			dish.reparent(self)
			dish.global_position = cupSpot.global_position
	elif !player.isStuck:
		ui.visible = false
		
		player.grabDish()

func steep(drink):
	if dish != null:
		if dish.base == "water" and dish.temperature == "hot":
			var i = drink - 1
			await get_tree().create_timer(0.1).timeout
			var jar = jarArray[i]
			jar.global_position = jarTTM.global_position
			
			
			await get_tree().create_timer(0.1).timeout
			
			steeper.global_position = cupSpot.global_position + Vector3(0,.07,0)
			
			await get_tree().create_timer(0.8).timeout
			
			jar.global_position = jPMArray[i].global_position
			
			dish.base = teaList[i]
			dish.liquid = jarColor[i]
			
			await get_tree().create_timer(0.8).timeout
			
			steeper.global_position = steeperPos.global_position
			
			await get_tree().create_timer(0.1).timeout
