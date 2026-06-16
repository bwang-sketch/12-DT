extends Node2D

var enemy_amount

@export var enemy_spawn: PathFollow2D
@export var enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	enemy_spawn.progress_ratio = randf_range(0.0, 1.0)
	enemy.global_position = enemy_spawn.global_position
	add_child(enemy)
	
	var enemy_amount = get_tree().get_nodes_in_group("enemies").size()
	if enemy_amount < 3:
		_spawn_enemy()
	return

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
