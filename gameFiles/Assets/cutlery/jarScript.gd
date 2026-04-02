extends Node

@onready var jarFullnessArray: Array[MeshInstance3D] = [$jarFullMesh,$jarHalfMesh,$jarNearMesh]

var fullness = 1

@onready var jarFullMesh = $jarFullMesh
@onready var jarHalfMesh = $jarHalfMesh
@onready var jarNearMesh = $jarNearMesh

func updateJar(color):
	var i = jarFullnessArray.size()
	while i > 0:
		var material = jarFullnessArray[i-1].get_active_material(0)
		if material != null:
			var uniqueMaterial = material.duplicate()
			uniqueMaterial.albedo_color = color
			jarFullnessArray[i-1].set_surface_override_material(0, uniqueMaterial)
		i -= 1
	
	fullness = randi_range(1, 3)
	
	match fullness:
		1:
			jarFullMesh.visible = true
			jarHalfMesh.visible = false
			jarNearMesh.visible = false
		2:
			jarFullMesh.visible = false
			jarHalfMesh.visible = true
			jarNearMesh.visible = false
		3:
			jarFullMesh.visible = false
			jarHalfMesh.visible = false
			jarNearMesh.visible = true
