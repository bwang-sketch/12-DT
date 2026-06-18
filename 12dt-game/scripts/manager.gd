extends Node2D

var enemy_amount
var projectile_enemy_amount

@export var enemy_spawn: PathFollow2D
@export var enemy_scene: PackedScene
@export var projectile_enemy_spawn: PathFollow2D
@export var projectile_enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _spawn_enemy() -> void:
	var enemy_amount = get_tree().get_nodes_in_group("enemies").size()
	if enemy_amount < 1:
		
		var enemy = enemy_scene.instantiate()
		enemy_spawn.progress_ratio = randf_range(0.0, 1.0)
		enemy.global_position = enemy_spawn.global_position
		add_child(enemy)
	
func _spawn_projectile_enemy() -> void:
	var projectile_enemy_amount = get_tree().get_nodes_in_group("projectile_enemies").size()
	if projectile_enemy_amount < 2:
		
		var projectile_enemy = projectile_enemy_scene.instantiate()
		projectile_enemy_spawn.progress_ratio = randf_range(0.0, 1.0)
		projectile_enemy.global_position = projectile_enemy_spawn.global_position
		add_child(projectile_enemy)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
