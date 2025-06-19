extends Area2D

var direction = 1

func _ready():
	pass


func _process(delta):
	translate(Vector2.RIGHT * direction)
	$Animatedsprite2d.flip_h = direction > 1

func _on_timer_timeout():
	direction *= -1 
