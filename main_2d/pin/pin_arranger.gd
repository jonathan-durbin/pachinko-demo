@tool
extends Node2D


@export_tool_button("Arrange") var a: Callable = arrange
@export var start_y: float = 100.0
@export var start_x: float = 50.0
@export var end_y_from_bottom: float = 100.0
@export var x_spacing_between_pins: float = 65.0
@export var y_spacing_between_pins: float = 65.0
@export var alternating_row_offset_x: float = 25.0
@export var pin_radius: float = 30.0
@export_range(0.0, 1.0, 0.001) var spring_chance_percent: float = 0.1
@export var pin: PackedScene


func arrange() -> void:
	# Clear previously spawned pins
	for child in get_children():
		child.queue_free()

	if pin == null:
		push_warning("No pin PackedScene assigned.")
		return

	var screen_size: Vector2 = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"),
	)
	var min_x: float = start_x
	var min_y: float = start_y
	var max_x: float = screen_size.x - pin_radius
	var max_y: float = screen_size.y - end_y_from_bottom

	# If the start position is already off-screen, nothing to do
	if min_x > max_x or min_y > max_y:
		return

	var row: int = 0
	var y: float = min_y

	while y <= max_y:
		var row_offset: float = (alternating_row_offset_x if (row % 2) == 1 else 0.0)
		var x: float = min_x + row_offset

		while x <= max_x:
			spawn_pin_at(x, y)
			x += x_spacing_between_pins

		row += 1
		y += y_spacing_between_pins


func spawn_pin_at(x: float, y: float) -> void:
	var p: Pin = pin.instantiate()
	add_child(p)
	p.owner = self.owner
	p.is_springy = randf() < spring_chance_percent
	p.position = Vector2(x, y)
