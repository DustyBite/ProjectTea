extends Panel

var station: StaticBody3D

func _on_green_pressed() -> void:
	station.steep("green", Color(0.65, 0.85, 0.35))

func _on_black_pressed() -> void:
	station.steep("black", Color(0.35, 0.18, 0.08))

func _on_oolong_pressed() -> void:
	station.steep("oolong", Color(0.55, 0.35, 0.18))

func _on_white_pressed() -> void:
	station.steep("white", Color(0.95, 0.92, 0.75))

func _on_yellow_pressed() -> void:
	station.steep("yellow", Color(0.95, 0.75, 0.25))

func _on_dark_pressed() -> void:
	station.steep("dark", Color(0.25, 0.12, 0.05))

func _on_jasmine_pressed() -> void:
	station.steep("jasmine", Color(0.80, 0.95, 0.55))

func _on_earl_grey_pressed() -> void:
	station.steep("earlGrey", Color(0.32, 0.20, 0.12))

func _on_ginseng_pressed() -> void:
	station.steep("ginseng", Color(0.85, 0.65, 0.30))

func _on_chrysanthemum_pressed() -> void:
	station.steep("chrysanthemum", Color(0.98, 0.85, 0.40))
