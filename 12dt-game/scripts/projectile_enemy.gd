extends CharacterBody2D

const SPEED: float = 75.0
var player: CharacterBody2D
var health: int = 2
var can_attack: bool = true

@export var enemy_projectile_scene: PackedScene
@export var enemy_projectile_spawn: Marker2D
@export var pivot: Node2D
@export var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(player.global_position)
	velocity = SPEED * Vector2(1, 0).rotated(rotation)
	
	move_and_slide()

func take_damage() -> void:
	if health > 0:
		health -= 1
	else:
		queue_free()

func _damage_player(body: Node2D) -> void:
	if body == player:
		player.take_damage()

func _projectile_attack() -> void:
	var enemy_projectile = enemy_projectile_scene.instantiate()
	enemy_projectile.rotation = pivot.rotation
	enemy_projectile.global_position = enemy_projectile.global_position
	add_sibling(enemy_projectile)
	can_attack = false
	timer.start()


func _projectile_atk_cooldown() -> void:
	can_attack = true
