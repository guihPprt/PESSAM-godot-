extends Node2D

@onready var mobile_hud

func _ready() -> void:
	mobile_hud = get_tree().current_scene.get_node("MobileHUD")

	
	if OS.get_name() != "Android":
		Global.on_phone = false
		mobile_hud.queue_free()

func _process(delta: float) -> void:
	
	var joypads = Input.get_connected_joypads()
	
	if joypads.size() > 0 or Global.on_phone:
		Global.gamepad = true
	else:
		Global.gamepad = false
	if Input.is_action_just_pressed("fs"):
		if Global.fullscreen:
			Global.fullscreen = false
			get_window().mode = Window.MODE_WINDOWED
		else:
			get_window().mode = Window.MODE_FULLSCREEN
			Global.fullscreen = true
