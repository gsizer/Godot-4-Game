extends Node3D

@export var PlayerCharacter : CharacterBody3D
var CTRL : Controller

func _ready():
	CTRL = find_parent("GameController") as Controller
	CTRL.StartGame()
