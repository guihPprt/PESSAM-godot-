extends Control

@onready var LifeProgress = $LifeProgress
@onready var DamageText = preload("res://Prefabs/Enimy/text_damage.tscn")

func _process(delta: float) -> void:
	LifeProgress.value = lerp(float(LifeProgress.value),float(Global.player["Life"]),.5)
	if Global.player["AfterLife"] != Global.player["Life"]:
		var dtext = DamageText.instantiate()
		add_child(dtext)
		dtext.get_node("Label").text = "-"+str(Global.player["AfterLife"] - Global.player["Life"])
		dtext.global_position = $Node2D.global_position
		
		
