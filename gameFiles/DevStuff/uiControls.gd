extends Node

@export var player : CharacterBody3D
@export var open = true
var targetY
var moveSpeed = 5
var openPos = 736.0
var closedPos = 828.0

func _ready() -> void:
	if open:
		targetY = openPos
	else:
		targetY = closedPos

func _on_left_button_down() -> void:
	player.movement_input.x = -1

func _on_left_button_up() -> void:
	player.movement_input.x = 0
	
func _on_right_button_down() -> void:
	player.movement_input.x = 1

func _on_right_button_up() -> void:
	player.movement_input.x = 0

func _on_forward_button_down() -> void:
	player.movement_input.y = -1

func _on_forward_button_up() -> void:
	player.movement_input.y = 0
	
func _on_back_button_down() -> void:
	player.movement_input.y = 1

func _on_back_button_up() -> void:
	player.movement_input.y = 0

func _on_tilt_right_pressed() -> void:
	player.tilt(false)

func _on_tilt_left_pressed() -> void:
	player.tilt(true)

func _on_zoom_in_pressed() -> void:
	player.zoom(false)

func _on_zoom_out_pressed() -> void:
	player.zoom(true)

func _on_open_close_pressed() -> void:
	if open:
		targetY = closedPos
		open = false
	elif !open:
		targetY = openPos
		open = true

func _process(delta: float) -> void:
	self.position.y = lerp(self.position.y, targetY, moveSpeed * delta)
