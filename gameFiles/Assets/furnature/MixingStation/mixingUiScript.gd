extends Panel

var station: StaticBody3D

func _on_chocolate_pressed() -> void:
	station.mixBase("chocolate", Color(0.30, 0.18, 0.10))

func _on_matcha_pressed() -> void:
	station.mixBase("matcha", Color(0.45, 0.75, 0.20))

func _on_chai_pressed() -> void:
	station.mixAddCol("chai", Color(0.75, 0.45, 0.20), 0.25)

func _on_milk_powder_pressed() -> void:
	station.mixAddCol("milkPowder", Color(0.95, 0.90, 0.75), 0.35)

func _on_taro_pressed() -> void:
	station.mixBase("taro", Color(0.70, 0.55, 0.75))

func _on_hojicha_pressed() -> void:
	station.mixBase("hojicha", Color(0.55, 0.30, 0.15))

func _on_honey_pressed() -> void:
	station.mixAdd("honey")

func _on_cane_sugar_pressed() -> void:
	station.mixAdd("caneSugar")

func _on_brown_sugar_pressed() -> void:
	station.mixAdd("brownSugar")

func _on_vanilla_syrup_pressed() -> void:
	station.mixAdd("vanillaSyrup")

func _on_lemon_pressed() -> void:
	station.mixAdd("lemon")

func _on_cinamon_pressed() -> void:
	station.mixAdd("cinamon")

func _on_ginger_pressed() -> void:
	station.mixAdd("ginger")

func _on_peach_pressed() -> void:
	station.mixAdd("peach")

func _on_lychee_pressed() -> void:
	station.mixAdd("lychee")

func _on_rose_pressed() -> void:
	station.mixAdd("rose")

func _on_lavender_pressed() -> void:
	station.mixAdd("lavender")
