extends Control

@onready var label : Label = $MarginContainer/Label

var framerate : float = 0.0
var framecount : int = 0
var lastTime : float = 0.0
var currentTime : float = 0.0
var debugInfo : String = ""
var debugString : String = "Frames Per Second: {FPS}\n"

func _input(event):
	if event.is_action_released("toggle_debug_info"):
		if self.is_visible_in_tree():
			self.hide()
		else:
			self.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# calc framerate
	framecount += 1
	currentTime = Time.get_ticks_msec()
	var elapsedTime = currentTime - lastTime
	if elapsedTime >= 1000:
		framerate = framecount / (elapsedTime / 1000)
		framecount = 0
		lastTime = currentTime
		# update Label Text if visible
		if is_visible_in_tree():
			# apply variables to debugString
			debugInfo = debugString.format( {"FPS":framerate} )
			label.set("text", debugInfo)
