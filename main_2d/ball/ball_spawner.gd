extends Node2D


@export var cycles_per_second: float = 300.0
@export var ball_initial_impulse: float = 50.0
@export var wait_time: float = 0.5
@export var travel_x_start: float = 50.0
@export var ball_scene: PackedScene

# Special ball that we keep a reference to
var traveling_ball: Ball
# How far the traveling ball moves left and right
var travel_width: float
# Time accumulating
var t: float = 0.0


func _ready() -> void:
	# Calculate width to be travel_x_start away from left and right side
	travel_width = get_viewport_rect().size.x - (travel_x_start * 2.0)

	traveling_ball = ball_scene.instantiate()
	add_child(traveling_ball)

	# Allows it to be moved manually via script
	traveling_ball.freeze = true

	# Make it invisible to other physics objects
	traveling_ball.collision_layer = 0
	traveling_ball.collision_mask = 0

	# Starting position
	traveling_ball.position.x = travel_x_start


func _physics_process(delta: float) -> void:
	t += delta # Accumulate time
	var offset: float = pingpong(t * cycles_per_second * travel_width, travel_width)
	traveling_ball.position.x = travel_x_start + offset


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		if not traveling_ball.visible:
			return
		traveling_ball.hide()
		get_tree().create_timer(wait_time).timeout.connect(func(): traveling_ball.show())
		spawn_ball()


func spawn_ball() -> void:
	var b: Ball = ball_scene.instantiate()
	add_child(b)
	b.position = traveling_ball.position
	b.apply_central_impulse(
		Vector2(randf_range(-0.2, 0.2), -1.0) # Up, but randomly slightly left or right
		* ball_initial_impulse
	)
