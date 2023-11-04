extends Node3D

@export var PlayerCharacter : CharacterBody3D
@export var WorldMap : String = "res://scenes/world_terrain_3d.tscn"
var CTRL : Controller
var WorldData : Node

func _ready():
	CTRL = find_parent("GameController") as Controller
	WorldData = Adopt(WorldMap)
	CTRL.StartGame()

# become parent of Node
func Adopt( scene ) -> Node:
	var resNode = load(scene)
	var instNode = resNode.instantiate()
	add_child(instNode)
	instNode.reparent(self)
	return instNode
