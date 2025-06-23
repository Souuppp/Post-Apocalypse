extends CharacterBody2D

@export var speed: float = 100.0
@export var player_path: NodePath

var player: Node2D

func _ready() -> void:
	if player_path != null and has_node(player_path):
		player = get_node(player_path)
	else:
		push_warning("Player path is invalid or player node not found.")

func _physics_process(_delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		var movement = direction * speed
		velocity = movement
		move_and_slide()
