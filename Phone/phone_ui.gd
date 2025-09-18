extends Control

@onready var Normal : Control = $Normal
@onready var Inv : Control = $Inventory
@onready var Dialog : Control = $Dialog

func _process(delta: float) -> void:
	if Global.on_inv:
		Normal.visible = false
		Inv.visible = true
		Dialog.visible = false
	elif Global.on_dialog:
		Normal.visible = false
		Inv.visible = false
		Dialog.visible = true
	else:
		Normal.visible = true
		Inv.visible = false
		Dialog.visible = false
