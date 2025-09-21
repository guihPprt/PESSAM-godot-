extends CharacterBody2D

var body: Node2D = null

var direction = Vector2(-10,0)
@onready var lifebar = $LifeBar
var damage_timer = null
var damage = 10
var life = 10
func _ready() -> void:
	# Inicia o timer de dano ao entrar na cena
	
	damage_timer = Timer.new()
	damage_timer.wait_time = 2.0
	damage_timer.one_shot = false
	damage_timer.autostart = true
	damage_timer.timeout.connect(_on_damage_timer_timeout)
	add_child(damage_timer)



func _on_damage_timer_timeout() -> void:
	take_damage()

func on_killed(id):
	if (id == self):
		life-=5
		velocity.x += 500
		velocity.y -= 500
		move_and_slide()
		if life <= 0:
			$AnimatedSprite2D.visible = false
			lifebar.visible = false
			$CPUParticles2D.emitting = true
			await get_tree().create_timer(.5).timeout
			queue_free()

func take_damage() -> void:
	if body != null and body.name == "Player":
		Global.player["Life"] -= damage
		# Você pode adicionar animação ou tempo de vida ao texto antes de removê-lo
		var remove_timer = Timer.new()
		remove_timer.wait_time = .01
		remove_timer.one_shot = true
		remove_timer.autostart = true
		add_child(remove_timer)

		# Conecta o timeout do timer à função que remove o texto
		remove_timer.timeout.connect(func():
			Global.player["AfterLife"] = Global.player["Life"]
		)
		
func _process(delta: float) -> void:
	$AnimatedSprite2D.play("walking")
	lifebar.value = life
	
	
	
	velocity = direction
	if not is_on_floor():
			velocity += get_gravity() * delta
	if (position.x < get_tree().current_scene.get_node("Player").position.x):
		velocity.x = 10
		$AnimatedSprite2D.scale.x = lerp($AnimatedSprite2D.scale.x,1.0,.15)
	else:
		velocity.x = -10
		$AnimatedSprite2D.scale.x = lerp($AnimatedSprite2D.scale.x,-1.0,.15)
	
	move_and_slide()
func _on_area_2d_body_entered(body: Node2D) -> void:
	self.body = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if self.body == body:
		self.body = null
