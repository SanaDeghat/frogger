extends Node2D
func game_over():
	pass
@onready var label: Label = $CanvasLayer/SpriteSheetForBasicPackCopy4/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	label.text=str(global.gold)
