extends DishBase

var base: String = "Empty"
var mixins: Array[String] = ["Empty","Empty","Empty","Empty"]
var temperature: String = "warm"
var isDirty = false
var type = "isCup"

@onready var mesh:= $cupMesh
@onready var water:= $water
@onready var liquid: Color = Color(1,1,1)

#---------------------
# Material Nodes

@onready var hotMat: Material = preload("res://Assets/cutlery/dishmatHot.tres")
@onready var coldMat: Material = preload("res://Assets/cutlery/dishmatCold.tres")
@onready var baseMat: Material = preload("res://Assets/cutlery/dishmatTemp1.tres")

func _process(_delta: float) -> void:
	checkTemp()
	
	updateLiquidColor()

func fill(value):
	base = value
	match value:
		"Empty":
			water.visible = false
		"water":
			water.visible = true
			liquid =  Color(1,1,1)

func empty():
	base = "Empty"
	temperature = "warm"
	water.visible = false
	var i = 4
	while i > 0:
		i -= 1
		mixins[i] = "Empty"

func updateLiquidColor():
	var material = water.get_active_material(0)
	if material != null:
		var uniqueMaterial = material.duplicate()
		uniqueMaterial.albedo_color = liquid
		water.set_surface_override_material(0, uniqueMaterial)

func checkTemp():
	match temperature:
		"warm":
			mesh.material_override = baseMat
		"hot":
			mesh.material_override = hotMat
		"cold":
			mesh.material_override = coldMat
