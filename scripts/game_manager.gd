extends Node

# Stats
var HP: float = 30

# Other node references
var parent: Node
var healthLabel: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	healthLabel = parent.get_node("HealthPoints")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateHealthLabel()


func updateHP(amount:float):
	if HP >= 50 and amount > 0: return
	HP += amount

func updateHealthLabel():
	healthLabel.text = "HP: %d" % [HP]
