extends Camera2D
@onready var player: CharacterBody2D = $"../CharacterBody2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x=player.position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#position.y=player.position.y
	if (global.game_running):
		position.y-=0.5
		if player.position.y<position.y-100:
				position.y=player.position.y+100
		elif  player.position.y>position.y+325:
			get_parent().game_over(player.score)
