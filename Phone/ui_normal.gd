extends Control


func _on_right_button_down() -> void:
	Input.action_press("a")


func _on_right_button_up() -> void:
	Input.action_release("a")


func _on_left_button_down() -> void:
	Input.action_press("d")


func _on_left_button_up() -> void:
	Input.action_release("d")


func _on_x_button_down() -> void:
	Input.action_press("e")


func _on_x_button_up() -> void:
	Input.action_release("e")


func _on_a_button_down() -> void:
	Input.action_press("jump")

func _on_a_button_up() -> void:
	Input.action_release("jump")


func _on_y_button_down() -> void:
	Input.action_press("inv")


func _on_y_button_up() -> void:
	Input.action_release("inv")


func _on_b_button_down() -> void:
	Input.action_press("q")


func _on_b_button_up() -> void:
	Input.action_release("q")
