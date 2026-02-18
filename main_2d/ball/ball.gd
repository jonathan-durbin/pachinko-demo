extends RigidBody2D
class_name Ball

@export var bounce_strength: float = 500.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	if global_position.y > (get_viewport_rect().size.y + 500):
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body is Pin and body.is_springy:
		var to_ball: Vector2 = body.global_position.direction_to(global_position)
		apply_central_impulse(to_ball * bounce_strength)
		if body.has_method("tween_sprite"):
			body.tween_sprite()
		if body.has_method("spawn_ball_at") and randf() < 0.1:
			body.spawn_ball_at(global_position)
