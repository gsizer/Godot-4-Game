extends Node

enum Dice { D4=4, D6=6, D8=8, D10=10, D20=20, D100=100 }
@export var RollHistory : Dictionary = {}

################################################################################
# Accepts COUNT:int of dice with FACES:int
# Returns Array of Int
func Roll( Count:int=1, Faces:Dice=Dice.D4, StoreResults:bool=false ) -> Array:
	var rolls : Array = []
	for c in Count:
		rolls.append( randi_range(1,Faces) )
	if StoreResults:
		print_debug("Roll: {C}D{F}\nResult: {R}".format({"C":Count, "F":Faces, "R":rolls}))
		RollHistory[RollHistory.size()] = rolls
	return rolls

func _ready():
	RollHistory.clear()
	Roll( 10, Dice.D4, true )
