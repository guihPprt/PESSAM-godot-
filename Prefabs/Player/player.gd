extends CharacterBody2D

const SPEED := 100.0
const JUMP_VELOCITY := -200.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var atk: Area2D = $Area2D
@onready var aura_text: Label = $SubViewport/Label
@onready var light: PointLight2D = $PointLight2D
@onready var particles: CPUParticles2D = $CPUParticles2D

@export var inv: Inventory
@export var inv_ui: Control
@export var cam: Camera2D
@export var aura_zoom := 10.0

signal kill


var raw_dir := 1.0
var dir := raw_dir
var letters := [
	"a","b","c","d","e","f","g","h","i","j","k","l","m",
	"n","o","p","q","r","s","t","u","v","w","x","y","z"
]
var enimy_on_proximity: Array = []

func _physics_process(delta: float) -> void:
	if !inv_ui.is_open and !Global.paused:
		light.visible = inv.selected and inv.selected.Item and inv.selected.Item.name == "Torch"

		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("d", "a")
		dir = lerp(dir, raw_dir, 0.15)
		anim.scale.x = dir

		if Input.is_action_just_released("atk"):
			for enemy in enimy_on_proximity:
				aura_text.text = letters[randi_range(0, letters.size()-1)]
				kill.emit(enemy)
	
		aura_text.text = letters[randi_range(0, letters.size())-1]
		if Input.is_action_pressed("atk"):
			cam.zoom = cam.zoom.lerp(Vector2(aura_zoom, aura_zoom), 0.01)
			particles.emitting = true
			
			
		else:
			cam.zoom = cam.zoom.lerp(Vector2(4.0, 4.0), 0.2)
			particles.emitting = false

		if direction != 0:
			atk.scale.x = direction
			raw_dir = direction
			velocity.x = direction * SPEED
			anim.play("walking")
		else:
			anim.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

func collect(item):
	inv.Insert(item)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enimy"):
		enimy_on_proximity.append(body)
		if not is_connected("kill", Callable(body, "on_killed")):
			kill.connect(Callable(body, "on_killed"))
	
		get_window().title = body.name

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enimy"):
		enimy_on_proximity.erase(body)
