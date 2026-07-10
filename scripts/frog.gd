extends CharacterBody2D

const TILE_SIZE = 80

const SPEED = 200.0

var target_position: Vector2
var moving = false
@onready var sprites: AnimatedSprite2D = $AnimatedSprite2D
func _ready():
	target_position = global_position

func _physics_process(delta):
	if !moving:
		var direction = Vector2.ZERO

		if Input.is_action_just_pressed("ui_left"):
			direction = Vector2.LEFT
			sprites.play("jump")
		elif Input.is_action_just_pressed("ui_right"):
	
			sprites.play("jump")
			direction = Vector2.RIGHT
		elif Input.is_action_just_pressed("ui_up"):
			sprites.play("jump")
			direction = Vector2.UP
		elif Input.is_action_just_pressed("ui_down"):
			direction = Vector2.DOWN
			sprites.play("jump")
		if direction != Vector2.ZERO:
			 
			sprites.flip_h=(direction!=Vector2(1,0))
			target_position += direction * TILE_SIZE
			moving = true

	if moving:
		global_position = global_position.move_toward(target_position, SPEED * delta)

		if global_position.distance_to(target_position) < 1:
			global_position = target_position
			moving = false
