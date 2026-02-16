extends Area2D


@export var score_value: float = 1.0


@onready var label: Label = $Label


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	label.text = str(score_value)


func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		SignalBus.score_added.emit(score_value)
