extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount_text: Label = $CenterContainer/Panel/Label

var Item
func update(slot: InventorySlot):
	if !slot or !slot.Item:
		Item = null
		item_visual.visible = false
		amount_text.visible = false
	else:
		Item = slot.Item
		item_visual.visible = true
		item_visual.texture = Item.texture
		amount_text.visible = true
		amount_text.text = str(slot.ammount)
		
func remove(slot: InventorySlot):
		Item = null
		item_visual.visible = false
		amount_text.visible = false
		slot.ammount = 0
