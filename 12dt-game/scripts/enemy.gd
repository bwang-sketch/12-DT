extends CharacterBody2D

const ENERGY_RECHARGE: int = 2
const SPEED: float = 175.0
var player: CharacterBody2D
var health: int = 6
var points_for_kill = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(player.global_position)
	velocity = SPEED * Vector2(1, 0).rotated(rotation)
	
	move_and_slide()

#Enemy takes damage when entering player attacks. If enemy dies (health <=0) bar value is set to availablee
func take_damage() -> void:
	if health > 0:
		health -= 1
	if health <= 0:
		player.score += 1
		var energy_bars: Array[Node] = player.energy_ui.get_children()
		var gained_energy: int = 0
		for bar in energy_bars:
			if bar.value == 100 and gained_energy < ENERGY_RECHARGE:
				bar.value = 0.0
				gained_energy += 1
		Global.current_score += points_for_kill
		queue_free()

#Runs player take_damage() function when enemy body hits player body
func _damage_player(body: Node2D) -> void:
	if body == player:
		player.take_damage()
