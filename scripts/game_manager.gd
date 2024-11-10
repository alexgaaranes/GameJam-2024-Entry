extends Node

# Stats
const maxHP = 30
var HP: float = maxHP

# Other node references
var parent: Node
var healthLabel: Label
var healthBar: ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	healthLabel = parent.get_node("HealthPoints")
	healthBar = healthLabel.get_node("Value")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func updateHP(amount:float):
	if HP >= maxHP and amount > 0: return
	HP += amount
	if HP < 0: HP = 0
	healthBar.scale = Vector2((HP/30)*10.1,0.796249)

func getHP():
	return HP
