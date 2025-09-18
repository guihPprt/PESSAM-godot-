extends Control

var is_open = false
var y_raw_offset: float = 600
var y_offset: float = 600

@onready var inv: Inventory = preload("res://Inventory/PlayerInventory.tres")
@onready var Slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var columns: int = $NinePatchRect/GridContainer.columns
@onready var selected_display := $NinePatchRect/NinePatchRect2/Sprite2D

var selected_index := 0

func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
	update_selection()
	close()

func update_slots():
	for i in range(min(inv.slots.size(), Slots.size())):
		Slots[i].update(inv.slots[i])

func handle_nav():
	if Input.is_action_just_pressed("ui_right"):
		selected_index = min(selected_index + 1, Slots.size() - 1)
		update_selection()
	elif Input.is_action_just_pressed("ui_left"):
		selected_index = max(selected_index - 1, 0)
		update_selection()
	elif Input.is_action_just_pressed("ui_down"):
		selected_index = min(selected_index + columns, Slots.size() - 1)
		update_selection()
	elif Input.is_action_just_pressed("ui_up"):
		selected_index = max(selected_index - columns, 0)
		update_selection()

	if Input.is_action_just_pressed("q"):
		var slot_item = Slots[selected_index].Item
		if slot_item and slot_item.prefab_path != "":
			var item_scene: PackedScene = ResourceLoader.load(slot_item.prefab_path)
			if item_scene:
				var item_inst = item_scene.instantiate()
				var player_node = get_tree().current_scene.get_node_or_null("Player")
				if player_node:
					item_inst.global_position = player_node.global_position
					get_tree().current_scene.add_child(item_inst)
					inv.remove_item(selected_index)
					
	if Input.is_action_just_pressed("e"):
		var selected_slot : InventoryItem = inv.select(selected_index)

		if selected_slot and selected_slot.texture:
			selected_display.visible = true
			selected_display.texture = selected_slot.texture
		else:
			selected_display.visible = false


func update_selection():
	for i in range(Slots.size()):
		Slots[i].modulate = Color(1, 1, 1)
	Slots[selected_index].modulate = Color(1, 1, 0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inv"):
		if is_open:
			close()
		else:
			open()

	if is_open:
		handle_nav()

	y_offset = lerp(y_offset, y_raw_offset, 0.15)
	position.y = y_offset

func open():
	Global.on_inv = true
	y_raw_offset = 0
	is_open = true

func close():
	Global.on_inv = false
	y_raw_offset = 600
	is_open = false
