class Quest extends Node:
	
	enum Category { Visit=10, Kill=20, Defend=30, Escort=40 }
	
	var Objective : Dictionary = {
		"Category":Category.Visit,
		"Location":Vector3.ZERO,
		"Destination":Vector3.ONE,
		"Target":"",
		"Count":0
	}
	
	var Name : String = ""
	var Description : String = ""
	var Objectives : Array = []
	
	func _init():
		Objectives.clear()
	
	func AddObjective(objective:Dictionary)->void:
		Objectives.append(objective)
	
	func RemoveObjective(objective:Dictionary)->void:
		if Objectives.has(objective):
			var idx:int = Objectives.find(objective)
			Objectives.pop_at( idx )
	
