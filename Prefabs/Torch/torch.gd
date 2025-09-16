extends RigidBody2D

@export var item: InventoryItem

var prox = false
var player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.position.y += -sin(Time.get_ticks_msec()*.010)*.2
	
	if prox:
		if Input.is_action_just_pressed("e"):
			player.collect(item)
			queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		prox = true
		player = body
		$Label.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$Label.visible = false
		prox = false
