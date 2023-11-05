class Quest extends Node:
	
	enum Category { Visit=10, Kill=20, Defend=30, Escort=40 }
	enum Status { Locked=0, Available=10, InProgress=20, Complete=30, Rewarded=40, Failed=50, Aborted=60}
	var Objective : Dictionary = {
		"Category":Category.Visit,
		"Location":Vector3.ZERO,
		"Destination":Vector3.ONE,
		"Target":Node,
		"Status":Status.Locked
	}
	
	var Title : String = ""
	var Description : String = ""
	var Objectives : Array = []
	
	func _init():
		Objective.make_read_only()
		Objectives.clear()
	
	func AddObjective(objective:Dictionary)->void:
		Objectives.append(objective)
		print_debug(
			"Quest: {T}\nAdded Objective:{I}:{O}".format(
				{"T":Title, "I":Objectives.size(), "O":objective}))
	
	func NewObjective() -> Dictionary:
		var newObj = Objective
		return newObj
	
	func RemoveObjective(objective:Dictionary)->void:
		if Objectives.has(objective):
			var idx:int = Objectives.find(objective)
			var obj = Objectives.pop_at( idx )
			print_debug(
				"Quest: {T}\nRemoved Objective:{I}:{O}".format(
					{"T":Title, "I":idx, "O":obj}))
