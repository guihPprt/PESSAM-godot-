extends Node2D

@onready var mobile_hud

func _ready() -> void:
	mobile_hud = get_tree().current_scene.get_node("MobileHUD")
	
	if OS.get_name() != "Android":
		mobile_hud.queue_free()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fs"):
		if Global.fullscreen:
			Global.fullscreen = false
			get_window().mode = Window.MODE_WINDOWED
		else:
			get_window().mode = Window.MODE_FULLSCREEN
			Global.fullscreen = true
