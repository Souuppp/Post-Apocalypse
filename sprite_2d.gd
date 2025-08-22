extends Sprite2D

const SPEED := 200.0

func _on_area_2d_body_entered(body: Node2D):
	if body is Player:
		body.add_score(1)
		queue_free()
