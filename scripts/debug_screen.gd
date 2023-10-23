extends Control

@onready var label : Label = $MarginContainer/Label

var framerate : float = 0.0
var framecount : int = 0
var uptime : float = 0.0
var debugInfo : String = ""
var debugString : String = "Up Time: {T}\nFrame Count: {C}\nFrame Rate: {R}"

func _input(event):
	if event.is_action_released("toggle_debug_info"):
		if self.is_visible_in_tree():
			self.hide()
		else:
			self.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# calc framerate
	framecount += 1
	uptime += delta
	framerate = framecount / (delta - uptime)
	# apply variables to debugString
	debugInfo = debugString.format( {"T":uptime, "C":framecount, "R":framerate} )
	# update Label Text if visible
	if is_visible_in_tree():
		label.set("text", debugInfo)
