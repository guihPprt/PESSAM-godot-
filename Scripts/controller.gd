extends Node2D


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fs"):
		if Global.fullscreen:
			Global.fullscreen = false
			get_window().mode = Window.MODE_WINDOWED
		else:
			get_window().mode = Window.MODE_FULLSCREEN
			Global.fullscreen = true
