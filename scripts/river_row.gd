extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer

@export var floaty: PackedScene
@export var min_gap := 180.0
@export var max_gap := 900.0

var river_width: float
var direction := 1
var speed := 1.25


func _ready():
	river_width = get_viewport_rect().size.x
	speed = randf_range(0.5, 3)
	direction = [-1, 1].pick_random()

	spawn_initial_floaties()

	set_spawn_time()
	spawn_timer.start()


func spawn_initial_floaties():
	var x_position := 0.0

	while x_position < river_width:
		spawn_log(x_position)
		x_position += randf_range(min_gap, max_gap)


func _on_spawn_timer_timeout():
	spawn_floaty()
	set_spawn_time()


func set_spawn_time():
	var gap = randf_range(min_gap, max_gap)
	spawn_timer.wait_time = gap / (speed * 100.0)


func spawn_floaty():
	if direction == 1:
		spawn_log(river_width + 50)
	else:
		spawn_log(-50)


func spawn_log(x: float):
	var log = floaty.instantiate()

	log.position = Vector2(x, 41)
	log.dir = direction
	log.speed = speed

	add_child(log)
