extends Node2D

@export var grass: PackedScene
@export var rock: PackedScene
@export var river: PackedScene
@export var flowers: PackedScene

@onready var camera: Camera2D = $"../Camera2D"

var row_spacing: float = 80.0
var spawn_buffer: float = 1200.0   
var destroy_buffer: float = 400.0 

var next_spawn_y: float = -400.0
var scenes: Array = []

func _ready() -> void:
	scenes = [ flowers,grass,rock,river]
	

func _process(delta: float) -> void:
	var target_generation_y = camera.global_position.y - spawn_buffer
	while next_spawn_y > target_generation_y:
		spawn_row()
		
	for chi in get_children():
		if chi.global_position.y > camera.global_position.y + destroy_buffer:
			chi.queue_free()

func spawn_row() -> void:
	var row = scenes.pick_random().instantiate()
	row.add_to_group("rows")
	row.position.y = next_spawn_y
	add_child(row)
	
	next_spawn_y -= row_spacing
