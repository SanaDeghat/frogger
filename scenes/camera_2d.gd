extends Camera2D
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x=character_body_2d.position.x
	position.y=character_body_2d.position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#position.y=character_body_2d.position.y
	position.y-=0.25
	print(global_position.y)

	if character_body_2d.position.y<position.y-100:
			position.y=character_body_2d.position.y+100
