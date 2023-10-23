extends Node3D

var CTRL : Controller
@export var Player : CharacterBody3D

func _ready():
	CTRL = find_parent("GameController") as Controller
	CTRL.StartGame()
