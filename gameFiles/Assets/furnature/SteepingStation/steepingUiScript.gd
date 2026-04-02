extends Panel

var station: StaticBody3D

func _on_green_pressed() -> void:
	station.steep(1)

func _on_black_pressed() -> void:
	station.steep(2)

func _on_oolong_pressed() -> void:
	station.steep(3)

func _on_white_pressed() -> void:
	station.steep(4)

func _on_yellow_pressed() -> void:
	station.steep(5)

func _on_dark_pressed() -> void:
	station.steep(6)

func _on_jasmine_pressed() -> void:
	station.steep(7)

func _on_earl_grey_pressed() -> void:
	station.steep(8)

func _on_ginseng_pressed() -> void:
	station.steep(9)

func _on_chrysanthemum_pressed() -> void:
	station.steep(10)
