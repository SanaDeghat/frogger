extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer

@export var floaty: PackedScene
@export var river_width := 1280

var direction := 1
var speed := 1.0

@export var min_gap := 180
@export var max_gap := 900


func _ready():
	direction = [-1, 1].pick_random()
	speed = randf_range(1.25, 1.25)

	spawn_initial_floaties()

	set_spawn_time()
	spawn_timer.start()


func spawn_initial_floaties():
	var x_position = 0.0

	while x_position < river_width:
		var log = floaty.instantiate()

		log.position.x = x_position
		log.position.y = 41

		log.dir = direction
		log.speed = speed

		add_child(log)

		x_position += randf_range(min_gap, max_gap)


func _on_spawn_timer_timeout():
	spawn_floaty()
	set_spawn_time()


func set_spawn_time():
	var base_gap = randf_range(min_gap, max_gap)
	spawn_timer.wait_time = base_gap / (speed * 250.0)


func spawn_floaty():
	var log = floaty.instantiate()
	if direction == 1:
		log.position.x = river_width -30
	else:
		log.position.x = -50

	log.position.y = 41

	log.dir = direction
	log.speed = speed

	add_child(log)
