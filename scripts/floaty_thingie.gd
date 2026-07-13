extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
signal inside_floaty_thingie(floaty: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.animation= "1_"+str(randi_range(1, 4))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x-=0.25


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("body?")
