extends Node2D

@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var tile_map_layer_addons: TileMapLayer = $TileMapLayer2
@export var terrain = 0
func _ready() -> void:
	draw_terrain()


func draw_terrain():
	var cells = []

	for x in range(15):
		cells.append(Vector2i(x, 0))

	tile_map_layer.set_cells_terrain_connect(
		cells,
		0, 
		terrain
	)
	
	if tile_map_layer_addons:
		tile_map_layer_addons.set_cells_terrain_connect(
			cells,
			0, 
			terrain
		)
	
