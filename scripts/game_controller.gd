extends Node
class_name Controller

@export var Menu : String = "res://scenes/menu.tscn"
var InGame : bool = false
var _Menu_Instance : Node
var _Children : int

# Called when the node enters the scene tree for the first time.
func _ready():
	_Children = get_child_count()
	_Menu_Instance = Adopt(Menu)

func _process(_delta):
	# count children
	var c = get_child_count()
	if _Children != c:
		_Children = c
		print_debug("Root Child Count: {C}".format({"C":_Children}))
		for child in _Children:
			var n = get_child(child) as Node
			print_debug("Child [{I}] is \'{N}\'".format( { "I":child, "N":n.name } ) )

# become parent of Node
func Adopt( scene ) -> Node:
	var resNode = load(scene)
	var instNode = resNode.instantiate()
	add_child(instNode)
	instNode.reparent(self)
	return instNode
