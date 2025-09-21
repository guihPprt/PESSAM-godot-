extends RigidBody2D

@export var item: InventoryItem

var prox = false
var player = null
@onready var interact_text = $Label



var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://Dialog/Assets/faceset_player.png",
		"dialog": "CARAI [wave][rainbow freq=.7 sat=.8 val=0.8 speed=3.0]VIADO[/rainbow][/wave] UMA TOCHA",
		"title": "Player"
	},
	1: {
		"faceset": "res://Assets/Icons/torch.png",
		"dialog": "CARAI VIADO UMA MULHER [shake]DEPRESSIVA[/shake] QUE VAI SE [wave]MATAR[/wave]",
		"title": "Tocha"
	}
}

@export_category("HUD")
var _hud: CanvasLayer

const _DIALOG_SCREEN: PackedScene = preload("res://Dialog/dialog_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hud = get_tree().current_scene.get_node("HUD")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.position.y += -sin(Time.get_ticks_msec()*.010)*.2
	
	if Global.gamepad:
		interact_text.text = "-X-"
	else:
		interact_text.text = "-E-"
	
	if prox:
		if Input.is_action_just_pressed("e"):
			var _new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
			_new_dialog.data = _dialog_data
			_hud.add_child(_new_dialog)
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
