class Equipment extends Node:
	
	enum EquipmentQuality{
		White=10, Green=20, Blue=30, Purple=40, Red=50, Orange=60, Yellow=70, Black=80, Magenta=90
		}
	enum EquipmentRarity{
		Common=10, Uncommon=20, Niche=30, Rare=40, Epic=50, Legendary=60, Artifact=70, Mythic=80, Unique=90
		}
	enum EquipmentType{
		Armor=10, Consumable=20, Inventory=30, Weapon=40
		}
	enum ArmorType{
		None=0, Blunt=10, Slashing=20, Piercing=30, Energy=40, Explosive=50
		}
	enum DamageType{
		None=0, Blunt=10, Slashing=20, Piercing=30, Energy=40, Explosive=50, Timed=60
		}
	enum ConsumeType {
		None=0, Food=10, Hydration=20, Energy=30, Equipment=40, World=50, Quest=60
		}
	enum EffectiveRange {
		Melee=0, ShortRange=10, LongRange=20, Indirect=30, Artillery=40
		}

	var eName : String = "Skivvies of Noxious Odor"
	# grab the first and only result from the returned Array of 1D10
	var initRoll : int = DiceRoller.Roll( 1, DiceRoller.Dice.D10, true)[0]
	var eQuality := EquipmentQuality.Magenta
	var eRarity := EquipmentRarity.Unique
	var eType := EquipmentType.Armor
	var eArmor := ArmorType.None
	var eArmorValue := 0.0
	var eDamage := DamageType.Timed
	var eDamageValue := 0.0
	var eConsume := ConsumeType.None
	var eConsumeValue := 0.0
	var eRange := EffectiveRange.Melee
	var eIncrement := 42.0
	var eLastsFor := -1.0
	var _timer : Timer = Timer.new()
	
	func _to_string():
		return eName
	
	func _DamageOverTime() -> void :
		print_debug("{N} has dropped some residue".format({"N":eName}))
	
	func _ready():
		add_child(_timer)
		_timer.connect("timeout", _DamageOverTime)
		_timer.reparent(self)
		_timer.set_one_shot(false)
