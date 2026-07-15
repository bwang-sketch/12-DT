extends CharacterBody2D

const SPEED: float = 75.0
var player: CharacterBody2D
var health: int = 2
var can_attack: bool = true
var is_attacking: bool = false
var attack_freeze: float = 2
var attack_cooldown: float = 1


@export var enemy_projectile_scene: PackedScene
@export var enemy_projectile_spawn: Marker2D
@export var pivot: Node2D
@export var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(player.global_position)
	
	if can_attack:
		_projectile_attack()
	
	if is_attacking:
		velocity = Vector2.ZERO
	else:
		velocity = SPEED * Vector2(1, 0).rotated(rotation)
	move_and_slide()
	
func _projectile_attack() -> void:
	
	can_attack = false
	is_attacking = true
	
	var enemy_projectile = enemy_projectile_scene.instantiate()
	enemy_projectile.rotation = pivot.global_rotation
	enemy_projectile.global_position = enemy_projectile_spawn.global_position
	add_sibling(enemy_projectile)
	can_attack = false
	is_attacking = true
	timer.start()
	
	await get_tree().create_timer(attack_freeze).timeout
	is_attacking = false

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
	
func take_damage() -> void:
	if health > 0:
		health -= 1
	else:
		queue_free()

func _damage_player(body: Node2D) -> void:
	if body == player:
		player.take_damage()



func _projectile_atk_cooldown() -> void:
	print("Timer finished! Resetting attack.")
	can_attack = true
	is_attacking = false
