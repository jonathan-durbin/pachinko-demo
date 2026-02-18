extends Node


var score: float = 0.0


@onready var score_label: Label = %ScoreLabel


func _ready() -> void:
	SignalBus.score_added.connect(_on_score_added)
	#SignalBus.score_multiply.connect(_on_score_multiply)


func _on_score_added(value: float) -> void:
	score += value
	update_label()


#func _on_score_multiply(value: float) -> void:
	#score *= value
	#update_label()


func update_label() -> void:
	score_label.text = str(snappedf(score, 0.1))
