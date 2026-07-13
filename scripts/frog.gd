extends CharacterBody2D

const TILE_SIZE = 80
const SPEED = 350.0
const GRID_OFFSET = Vector2(40, 20)

var target_position: Vector2
var moving := false

var on_log := false
var log: Area2D = null
var river_y := 0.0

@onready var sprites = $AnimatedSprite2D


func _ready():
	global_position = snap_to_grid(global_position)
	target_position = global_position


func _physics_process(delta):

	# Follow the log only when standing still
	if on_log and log != null and !moving:
		global_position.x = log.global_position.x
		global_position.y = river_y

	if moving:
		global_position = global_position.move_toward(target_position, SPEED * delta)

		if global_position.distance_to(target_position) < 2:
			global_position = target_position
			global_position = snap_to_grid(global_position)
			target_position = global_position
			moving = false

		return

	var direction = Vector2.ZERO

	if Input.is_action_just_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("ui_up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2.DOWN

	if direction == Vector2.ZERO:
		return


	if direction.x != 0:
		sprites.flip_h = direction.x < 0

	
	global_position = snap_to_grid(global_position)

	var next_position = global_position + direction * TILE_SIZE

	if can_move_to(next_position):
		sprites.play("jump")
		target_position = next_position
		moving = true
func can_move_to(pos: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state

	var shape = CircleShape2D.new()
	shape.radius = 20 

	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(0, pos)
	query.collision_mask = 1 << 4

	var result = space_state.intersect_shape(query)

	return result.is_empty()

func snap_to_grid(pos: Vector2) -> Vector2:
	return Vector2(
		round((pos.x - GRID_OFFSET.x) / TILE_SIZE) * TILE_SIZE + GRID_OFFSET.x,
		round((pos.y - GRID_OFFSET.y) / TILE_SIZE) * TILE_SIZE + GRID_OFFSET.y
	)


func _on_river_collisions_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
	
	print("working")

	on_log = true
	log = area
	river_y = snap_to_grid(global_position).y - 20


func _on_river_collisions_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
	
		
	if area == log:
		on_log = false
		log = null


func _on_hitbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	print("working2")

	if !on_log:
		get_tree().paused = true





func _on_collisionbox_body_entered(body: Node2D) -> void:
	print("rarara")
