extends Node

enum Dice { D4=4, D6=6, D8=8, D10=10, D20=20, D100=100 }

var Count : int = 0
var Die : Dice = Dice.D4
var Rolls : Array = []
var Total : int = 0
var RollResult : Dictionary = { "Count"=0, "Faces"=Dice.D4, "Results"=Rolls, "Total"=0 }

@export var RollHistory : Dictionary = {}

################################################################################
# Accepts COUNT:int of dice with FACES:int
# Returns Array of Int
func Roll( count:int=1, faces:Dice=Dice.D4 ) -> Array:
	Rolls.clear()
	var thisResult = RollResult
	for c in count:
		Rolls.append( randi_range(1, faces) )
	thisResult["Count"]=count
	thisResult["Faces"]=faces
	thisResult["Rolls"]=Rolls
	thisResult["Total"]=Total
	RollHistory[RollHistory.size()] = thisResult
	return Rolls

func _ready():
	Rolls.clear()
	RollHistory.clear()
	Roll()
