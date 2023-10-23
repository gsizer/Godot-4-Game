extends Node
class_name Controller

@export var Menu : String = "res://scenes/menu.tscn"
@export var DebugScreen : String = "res://scenes/debug_screen.tscn"

var InGame : bool = false

var _Menu_Instance : Control
var _DebugScreen : Control
var _Children : int

func _process(_delta):
	# count children
	var c = get_child_count()
	if _Children != c:
		_Children = c
		print_debug("Root Child Count: {C}".format({"C":_Children}))
		for child in _Children:
			var n = get_child(child) as Node
			print_debug("Child [{I}] is \'{N}\'".format( { "I":child, "N":n.name } ) )

# Called when the node enters the scene tree for the first time.
func _ready():
	_Children = get_child_count()
	_DebugScreen = Adopt(DebugScreen)
	_Menu_Instance = Adopt(Menu)

# become parent of Node
func Adopt( scene ) -> Node:
	var resNode = load(scene)
	var instNode = resNode.instantiate()
	add_child(instNode)
	instNode.reparent(self)
	return instNode

func StartGame()->void:
	InGame = true
	_Menu_Instance.hide()
