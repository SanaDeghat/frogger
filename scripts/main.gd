extends Node2D
@onready var death_screen: CanvasLayer = $deathScreen
func game_over(score:int):
	death_screen.visible=true
	global.game_running=false
	if score>global.highscore:
		global.highscore=score
@onready var label: Label = $CanvasLayer/SpriteSheetForBasicPackCopy4/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	label.text=str(global.gold)
