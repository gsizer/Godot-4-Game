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
		None=0, Blunt=10, Slashing=20, Piercing=30, Energy=40, Explosive=50
		}
	enum ConsumeType {
		None=0, Food=10, Hydration=20, Energy=30, Equipment=40, World=50, Quest=60
		}
	var initRoll : Array = DiceRoller.Roll( 1, DiceRoller.Dice.D10, true)

