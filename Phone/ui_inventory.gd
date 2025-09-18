extends Control

func _on_x_button_down() -> void:
	Input.action_press("e")


func _on_x_button_up() -> void:
	Input.action_release("e")


func _on_y_button_down() -> void:
	Input.action_press("inv")


func _on_y_button_up() -> void:
	Input.action_release("inv")


func _on_b_button_down() -> void:
	Input.action_press("q")


func _on_b_button_up() -> void:
	Input.action_release("q")


func _on_left_button_down() -> void:
	Input.action_press("ui_left")


func _on_left_button_up() -> void:
	Input.action_release("ui_left")


func _on_right_button_down() -> void:
	Input.action_press("ui_right")


func _on_right_button_up() -> void:
	Input.action_release("ui_right")


func _on_up_button_down() -> void:
	Input.action_press("ui_up")


func _on_up_button_up() -> void:
	Input.action_release("ui_up")


func _on_down_button_down() -> void:
	Input.action_press("ui_down")


func _on_down_button_up() -> void:
	Input.action_release("ui_down")
