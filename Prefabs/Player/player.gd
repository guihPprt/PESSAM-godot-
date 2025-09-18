extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
@onready var anim = $AnimatedSprite2D

var raw_dir: float = 1
var dir: float = raw_dir

@export var inv: Inventory
@export var inv_ui: Control

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !inv_ui.is_open && !Global.paused:
		
		if inv.selected and inv.selected.Item and inv.selected.Item.name == "Torch":
			$PointLight2D.visible = true
		else:
			$PointLight2D.visible = false
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("d", "a")
		
		dir = lerp(dir,raw_dir,.15)
		anim.scale.x = dir
		
		
		
		
		if direction:
			raw_dir = direction
			velocity.x = direction * SPEED
			anim.play("walking")
		else:
			anim.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		
func collect(item):
	inv.Insert(item)
