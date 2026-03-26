extends CharacterBody3D

#---------------------
# Camera Nodes

var pixelResolution = 6
@onready var cameraNode := $CameraNode
@onready var camera := $CameraNode/Camera3D
var currentRotation := 0.0  # in radians
@export var rotateAngle := 45.0
var rotateSpeed = 5
@export var SVC : SubViewportContainer
@export var maxZoom: int = 8
@export var minZoom: int = 3

#---------------------
# Misc Nodes

@onready var playerNode := $playerNode
@onready var holdSpot := $playerNode/holdMarker

@onready var TempStand := $playerNode/standing
@onready var TempHold := $playerNode/holding

@onready var raycast := $playerNode/RayCast3D

# Dishes

var furniture
var dishHolding

#---------------------
# Movement Settings

@export var speed = 5.0
@export var jump_velocity = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var movement_input: Vector2 = Vector2.ZERO
var isStuck: bool = false

#---------------------
# DebugOptions

@export var overrideZoom: bool = false
@export var startZoom = 6

func _ready() -> void:
	if overrideZoom:
		while camera.size != startZoom:
			zoom(true)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	_apply_movement()
	move_and_slide()

	# Rotate mesh to face INPUT direction, not velocity
	var cam_basis = cameraNode.global_transform.basis
	var input_dir = (cam_basis * Vector3(
		movement_input.x,
		0,
		movement_input.y
	)).normalized()
	input_dir.y = 0

	if input_dir.length() > 0.1:
		var target_angle = atan2(input_dir.x, input_dir.z)
		playerNode.rotation.y = lerp_angle(
			playerNode.rotation.y,
			target_angle,
			10 * delta
		)

	# ... rest of your raycast code unchanged
	
	var previous_furniture = furniture

	if raycast.is_colliding():
		furniture = raycast.get_collider()
	else:
		furniture = null

	# If we moved off something (or onto something different), un-hover the old one
	if previous_furniture != furniture:
		if previous_furniture != null and previous_furniture.has_method("hover"):
			previous_furniture.hover(false)

		# Hover the new one (if any)
		if furniture != null and furniture.has_method("hover"):
			furniture.hover(true)


func _apply_movement() -> void:
	var cam_basis = cameraNode.global_transform.basis
	var direction = (cam_basis * Vector3(
		movement_input.x,
		0,
		movement_input.y
	)).normalized()
	
	# Zero out Y so camera tilt (if any) doesn't affect horizontal movement
	direction.y = 0
	direction = direction.normalized()
	
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)


func _process(delta: float) -> void:
	cameraNode.rotation.y = lerp_angle(cameraNode.rotation.y, currentRotation, rotateSpeed * delta)
	SVC.stretch_shrink = pixelResolution
	
	if dishHolding != null:
		TempHold.visible = true
		TempStand.visible = false
	else:
		TempHold.visible = false
		TempStand.visible = true


func _input(event: InputEvent) -> void:

	# -----------------
	# INTERACTION INPUT
	if event.is_action_pressed("interact"):
		if furniture != null:
			match furniture.type:
				"isTable":
					if dishHolding == null:
						grabDish()
					elif dishHolding != null:
						placeDish()
				"isBasin":
					if dishHolding != null:
						placeDish()
				"isDryingRack":
					print("GrabDish")
					if dishHolding == null:
						grabDish()
				"isInteractable":
					furniture.interaction(self)
	
	# -----------------
	# MOVEMENT INPUT
	
	if isStuck:
		return
	
	if event.is_action_pressed("forward"):
		movement_input.y = -1
	if event.is_action_released("forward"):
		movement_input.y = 0

	if event.is_action_pressed("back"):
		movement_input.y = 1
	if event.is_action_released("back"):
		movement_input.y = 0

	if event.is_action_pressed("left"):
		movement_input.x = -1
	if event.is_action_released("left"):
		movement_input.x = 0

	if event.is_action_pressed("right"):
		movement_input.x = 1
	if event.is_action_released("right"):
		movement_input.x = 0


	# -----------------
	# CAMERA CONTROLS

	if event.is_action_pressed("turnLeft"):
		tilt(true)

	if event.is_action_pressed("turnRight"):
		tilt(false)

	if event.is_action_pressed("zoomIn"):
		zoom(false)

	if event.is_action_pressed("zoomOut"):
		zoom(true)

# -----------------
# INTERACTION FUNCTIONS

func grabDish() -> void:
	if furniture.dish is Array:
		if furniture.dish.is_empty():
			return
		dishHolding = furniture.dish.back()
		furniture.dish.erase(dishHolding)
	else:
		if furniture.dish == null:
			return
		dishHolding = furniture.dish
		furniture.dish = null

	dishHolding.reparent(holdSpot)
	dishHolding.position = Vector3.ZERO

func placeDish() -> void:
	if dishHolding == null:
		return
	
	if furniture.dish is Array:
		furniture.placeDish(dishHolding, self)
	else:
		if furniture.dish != null:
			return
		furniture.placeDish(dishHolding)
		dishHolding = null

# -----------------
# CAMERA FUNCTIONS

func tilt(left: bool):
	if left:
		currentRotation -= deg_to_rad(rotateAngle)
	else:
		currentRotation += deg_to_rad(rotateAngle)
	
	currentRotation = wrapf(currentRotation, 0.0, TAU)

func zoom(A):
	if A:
		if camera.size != maxZoom:
			camera.size += 1
			pixelResolution -= .5
	elif !A:
		if camera.size != minZoom:
			camera.size -= 1
			pixelResolution += .5
