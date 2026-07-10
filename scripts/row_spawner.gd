extends Node2D
@export var grass: PackedScene
@export var rock: PackedScene
@export var river: PackedScene
@export var flowers: PackedScene
@onready var camera: Camera2D = $"../Camera2D"
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scenes = [
		grass,
		rock,
		river,
		flowers
	]
	for i in 9:
		var obstacle = scenes.pick_random().instantiate()
		obstacle.add_to_group("obstacles")
		obstacle.position.y=-370+ i*80
		add_child(obstacle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for chi in get_children():
		if chi.global_position.y>camera.global_position.y+400:
			chi.queue_free()
