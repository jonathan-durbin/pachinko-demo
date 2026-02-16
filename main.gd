extends Node2D


var score: float = 0.0

func _ready() -> void:
	SignalBus.score_added.connect(_on_score_added)


func _on_score_added(value: float) -> void:
	score += value
	print(score)
