extends StaticBody2D
class_name Pin


@export var is_springy: bool = false


const BALL: PackedScene = preload("uid://bv427jukmp1i6")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var main_2d: Node2D = $"../.."


var tween: Tween
var springy_color: Color = Color.DEEP_PINK


func _ready() -> void:
	if is_springy:
		sprite_2d.modulate = springy_color


func spawn_ball_at(global_pos: Vector2) -> void:
	var b: Ball = BALL.instantiate()
	main_2d.add_child.call_deferred(b) # Add child at the end of this frame
	b.global_position = global_pos


func tween_sprite() -> void:
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	# Tween up
	tween.tween_property(sprite_2d, "scale", Vector2(1.03, 1.03), 0.1)
	tween.parallel().tween_property(sprite_2d, "modulate", Color.FUCHSIA, 0.1)
	# Tween down
	tween.tween_property(sprite_2d, "scale", Vector2(0.25, 0.25), 0.1).from(Vector2(1.03, 1.03))
	tween.parallel().tween_property(sprite_2d, "modulate", springy_color, 0.1).from(Color.FUCHSIA)
