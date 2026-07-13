extends Node2D

@export var grass: PackedScene
@export var rock: PackedScene
@export var river: PackedScene
@export var flowers: PackedScene

@onready var camera: Camera2D = $"../Camera2D"

# Configuration variables
var row_spacing: float = 80.0
var spawn_buffer: float = 600.0   # How far ahead of the camera to generate rows
var destroy_buffer: float = 400.0 # How far behind the camera to delete rows

# Tracks the exact Y position of the next row to create
var next_spawn_y: float = -400.0
var scenes: Array = []

func _ready() -> void:
	scenes = [grass, rock, river, flowers]
	

func _process(delta: float) -> void:
	var target_generation_y = camera.global_position.y - spawn_buffer
	while next_spawn_y > target_generation_y:
		spawn_row()
		
	for chi in get_children():
		if chi.global_position.y > camera.global_position.y + destroy_buffer:
			chi.queue_free()

func spawn_row() -> void:
	var obstacle = scenes.pick_random().instantiate()
	obstacle.add_to_group("obstacles")
	obstacle.position.y = next_spawn_y
	add_child(obstacle)
	
	next_spawn_y -= row_spacing
