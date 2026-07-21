extends CharacterBody2D

var score = 0

const TILE_SIZE := 80
const SPEED := 300.0
const GRID_OFFSET := Vector2(40, 20)

const LOG_ALIGN_SPEED := 500.0
const MAX_QUEUE_SIZE := 4

var target_position: Vector2
var moving := false
var can_move := true

var move_queue: Array[Vector2] = []

var target_river_y := 0.0
var aligning_to_log := false
var on_log := false
var log: Area2D = null

@onready var sprites: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	global_position = snap_to_grid(global_position)
	target_position = global_position


func _physics_process(delta):

	# Follow the log
	if on_log and log != null and !moving:
		global_position.x = log.global_position.x

		if aligning_to_log:
			global_position.y = move_toward(
				global_position.y,
				target_river_y,
				LOG_ALIGN_SPEED * delta
			)

			if abs(global_position.y - target_river_y) < 1:
				global_position.y = target_river_y
				aligning_to_log = false
		else:
			global_position.y = target_river_y


	# Continue current movement
	if moving:
		global_position = global_position.move_toward(target_position, SPEED * delta)

		if global_position.distance_to(target_position) < 2:
			global_position = target_position
			target_position = global_position
			moving = false

		return


	# Queue inputs
	if Input.is_action_just_pressed("ui_left"):
		if move_queue.size() < MAX_QUEUE_SIZE:
			move_queue.append(Vector2.LEFT)

	if Input.is_action_just_pressed("ui_right"):
		if move_queue.size() < MAX_QUEUE_SIZE:
			move_queue.append(Vector2.RIGHT)

	if Input.is_action_just_pressed("ui_up"):
		if move_queue.size() < MAX_QUEUE_SIZE:
			move_queue.append(Vector2.UP)

	if Input.is_action_just_pressed("ui_down"):
		if move_queue.size() < MAX_QUEUE_SIZE:
			move_queue.append(Vector2.DOWN)


	# Wait until jump animation finishes
	if !can_move:
		return

	if move_queue.is_empty():
		return


	var direction = move_queue.pop_front()

	if direction.x != 0:
		sprites.flip_h = direction.x < 0


	var start_grid = snap_to_grid(global_position)
	var next_position = start_grid + direction * TILE_SIZE

	if can_move_to(next_position):
		sprites.play("jump"+str(global.currentSkin))
		can_move = false
		target_position = next_position
		moving = true


func _on_animated_sprite_2d_animation_finished():
	if sprites.animation == "jump"+str(global.currentSkin):
		can_move = true


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
	on_log = true
	log = area

	target_river_y = snap_to_grid(global_position).y - 20
	aligning_to_log = true


func _on_river_collisions_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
	if area == log:
		on_log = false
		log = null


func _on_hitbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	if !on_log:
		sprites.play("drown1")
		get_parent().game_over();
