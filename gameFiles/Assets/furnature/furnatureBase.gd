extends Node
class_name FurnatureBase

@export var mesh: MeshInstance3D
var material: Material
var hoverMat: Material

func _ready() -> void:
	material = mesh.get_active_material(0)
	hoverMat = mesh.get_active_material(0).duplicate()
	hoverMat.stencil_mode = 1

func hover(value):
	if value:
		mesh.material_override = hoverMat
	else:
		mesh.material_override = material
