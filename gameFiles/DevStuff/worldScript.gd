extends Node


@onready var pixelResolution : int = 6
var subViewportContainer : SubViewportContainer

@export var crtEffect: CanvasLayer
@export var rgbSeperator: CanvasLayer
var crtEffectOn: bool = false
var rgbSeperatorOn: bool = false

func _process(_delta: float) -> void:
	if crtEffect != null:
		crtEffect.visible = crtEffectOn
	
	if rgbSeperator != null:
		rgbSeperator.visible = rgbSeperatorOn

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("crtEffectDEV"):
		crtEffectOn = !crtEffectOn
	
	if Input.is_action_just_pressed("rgbEffectDev"):
		rgbSeperatorOn = !rgbSeperatorOn
