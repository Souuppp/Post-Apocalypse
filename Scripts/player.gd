extends CharacterBody2D

const SPEED := 200.0
const JUMP_FORCE := -355.0
const GRAVITY := 1000.0
const MAX_JUMPS := 1

var jumps_left := MAX_JUMPS
var is_attacking := false
var held_object: Node2D = null

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_area: Area2D = $PickupArea

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

		if Input.is_action_just_pressed("pickup"):
			pickup_or_drop()

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

func pickup_or_drop() -> void:
	if held_object:
		held_object.reparent(get_parent())
		held_object.position = global_position + Vector2(0, 16)
		held_object = null
	else:
		for body in pickup_area.get_overlapping_bodies():
			if body.is_in_group("Pickup"):
				held_object = body
				held_object.reparent(self)
				held_object.position = Vector2(0, -16)
				break

func take_damage() -> void:
	sprite.play("Hurt")
