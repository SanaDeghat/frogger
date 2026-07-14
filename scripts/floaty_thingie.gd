extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
signal inside_floaty_thingie(floaty: Node2D)
@export var dir=-1
@export var speed= 0.30
func _ready() -> void:
	animated_sprite_2d.animation= "1_"+str(randi_range(1, 4))


func _process(delta: float) -> void:
	position.x-=speed*dir
	if position.x<-100 or position.x>1400:
		queue_free()
