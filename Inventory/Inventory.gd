extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]

var selected: InventorySlot

func Insert(item: InventoryItem):
	var itemslots = slots.filter(func(slot): return slot.Item == item)
	
	if !itemslots.is_empty():
		itemslots[0].ammount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.Item == null)
		if !emptySlots.is_empty():
			emptySlots[0].Item = item
			emptySlots[0].ammount = 1
	
	update.emit()
	
func remove_item(index: int):
	if index >= 0 and index < slots.size():
		if(slots[index].ammount > 1):
			slots[index].ammount -= 1
			emit_signal("update")  # Atualiza a UI
		else:
			slots[index].Item = null
			slots[index].ammount = 0
			emit_signal("update")  # Atualiza a UI
			
func select(index: int):
	if index < 0 or index >= slots.size():
		return  # Índice inválido

	var slot := slots[index]

	if slot.Item == null or slot.ammount <= 0:
		# Slot vazio, tenta colocar o item selecionado nele
		if selected != null:
			slots[index] = selected
			emit_signal("update")
			selected = null
			return selected
			
	else:
		# Slot com item
		selected = InventorySlot.new()
		selected.Item = slot.Item
		selected.ammount = 1

		if slot.ammount == 1:
			remove_item(index)
		else:
			slot.ammount -= 1
			
		return selected.Item

				
				
			
