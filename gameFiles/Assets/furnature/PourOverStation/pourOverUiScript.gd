extends Panel

var station: StaticBody3D

func _on_medium_pressed() -> void:
	station.pourOver("medium", Color(0.45, 0.28, 0.12))

func _on_herbal_pressed() -> void:
	station.pourOver("herbal", Color(0.95, 0.85, 0.50))

func _on_dark_pressed() -> void:
	station.pourOver("dark", Color(0.20, 0.12, 0.06))

func _on_light_pressed() -> void:
	station.pourOver("light", Color(0.60, 0.38, 0.18))

func _on_decaf_pressed() -> void:
	station.pourOver("decaf", Color(0.40, 0.30, 0.18))

func _on_single_pressed() -> void:
	station.pourOver("single", Color(0.50, 0.25, 0.15))

func _on_hibiscus_pressed() -> void:
	station.pourOver("hibiscus", Color(0.75, 0.10, 0.20))

func _on_barley_pressed() -> void:
	station.pourOver("barley", Color(0.55, 0.40, 0.20))

func _on_roasted_corn_pressed() -> void:
	station.pourOver("roastedCorn", Color(0.90, 0.75, 0.30))

func _on_cascara_pressed() -> void:
	station.pourOver("cascara", Color(0.70, 0.30, 0.20))
