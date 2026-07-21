extends CharacterBody2D

var speed: float = 300.0
var can_attack: bool = true
var can_slash: bool = true
var health: int = 10
var energy: int = 10

@export var health_ui: ProgressBar
@export var energy_ui: ProgressBar
@export var melee_atk_scene: PackedScene
@export var melee_atk_spawn: Marker2D
@export var projectile_slash_scene: PackedScene
@export var projectile_slash_spawn: Marker2D
@export var pivot: Node2D
@export var timer: Timer
@export var timer2: Timer
@export var label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not timer2.time_left == 0:
		label.text = str(timer2.time_left)
	
	var direction: Vector2 = Vector2(0.0, 0.0)
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")

	velocity = speed * direction.normalized()
	
	pivot.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("ui_accept") and can_attack:
		_attack()
		
	if Input.is_action_pressed("slash") and can_slash:
		_slash()
		
	move_and_slide()

	
func _attack() -> void:
	var melee_atk = melee_atk_scene.instantiate()
	melee_atk.rotation = pivot.rotation
	melee_atk.global_position = melee_atk_spawn.global_position
	add_sibling(melee_atk)
	can_attack = false
	timer.start()

func _slash() -> void:
	var projectile_slash = projectile_slash_scene.instantiate()
	projectile_slash.rotation = pivot.rotation
	projectile_slash.global_position = projectile_slash_spawn.global_position
	add_sibling(projectile_slash)
	can_slash = false
	timer2.start()

func _melee_atk_cooldown() -> void:
	can_attack = true

func projectile_slash_cooldown() -> void:
	can_slash = true

	if can_slash == false:
		timer2 = get_node("projectile_slash_cooldown")
	
func take_damage() -> void:
	if health > 0:
		health -= 1
		health_ui.value = health
	else:
		get_tree().call_deferred("reload_current_scene")
