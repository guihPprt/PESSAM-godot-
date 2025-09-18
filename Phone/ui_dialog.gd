extends Control


func _on_a_button_down() -> void:
	Input.action_press("jump")


func _on_a_button_up() -> void:
	Input.action_release("jump")
