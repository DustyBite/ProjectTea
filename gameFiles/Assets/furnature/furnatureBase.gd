extends Node
class_name FurnatureBase

@export var mesh: MeshInstance3D
var material: Material
var hoverMat: Material

func _ready() -> void:
	makeHoverMat()

func hover(value):
	if value:
		mesh.material_override = hoverMat
	else:
		mesh.material_override = material

func makeHoverMat():
	material = mesh.get_active_material(0)
	hoverMat = mesh.get_active_material(0).duplicate()
	hoverMat.stencil_mode = 1
	hoverMat.stencil_color = Globals.stencilColor
	hoverMat.stencil_outline_thickness = Globals.stencilThickness
