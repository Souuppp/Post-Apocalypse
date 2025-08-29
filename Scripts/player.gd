extends CharacterBody2D
class_name Player

const SPEED := 200.0
const JUMP_FORCE := -355.0
const GRAVITY := 1000.0
const MAX_JUMPS := 1

var jumps_left := MAX_JUMPS
var is_attacking := false
var held_object: Node2D = null
var score := 0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var Coin_Sound = $AudioStreamPlayer2D 
@onready var score_label: RichTextLabel = $Camera2D/RichTextLabel

func _ready():
	add_to_group("Player")
	score_label.text = str(score)

func add_score(value):
	score += 1
	score_label.text = str(score)

func collect_letter():
	score += 1
	score_label.text = str(score)
	Coin_Sound.play()

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_input()
	move_and_slide()
	handle_animation()

func handle_input() -> void:
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	if not is_attacking:
		velocity.x = direction * SPEED
		if direction != 0:
			sprite.flip_h = direction < 0
		if Input.is_action_just_pressed("jump") and jumps_left > 0:
			velocity.y = JUMP_FORCE
			jumps_left -= 1
		if Input.is_action_just_pressed("attack"):
			attack()

	if is_on_floor():
		jumps_left = MAX_JUMPS

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

func handle_animation() -> void:
	if is_attacking:
		return
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("Jump_Up")
		else:
			sprite.play("Jump_Down")
	elif abs(velocity.x) > 10:
		sprite.play("Run")
	else:
		sprite.play("Idle")

func attack() -> void:
	is_attacking = true
	sprite.play("attack")
	await sprite.animation_finished
	is_attacking = false



func take_damage() -> void:
	sprite.play("Hurt")
