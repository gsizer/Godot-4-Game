extends GridMap

var permaGen : int = 10
var usedCellsPos : Array = []
var cellData : Array = []

func save() -> Dictionary:
	var save_dict : Dictionary = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"position" : position,
		"usedCellsPos" : usedCellsPos
	}
	for point in usedCellsPos:
		save_dict[point] = get_cell_item(point)
	return save_dict

func _ready():
	if mesh_library == null: mesh_library = preload("res://lib/ground.meshlib")
	clear()
	for i in permaGen:
		for j in permaGen:
			set_cell_item(Vector3(i,0,j), 0, 0)
			set_cell_item(Vector3(-i,0,j), 0, 0)
			set_cell_item(Vector3(i,0,-j), 0, 0)
			set_cell_item(Vector3(-i,0,-j), 0, 0)
	usedCellsPos = get_used_cells()
