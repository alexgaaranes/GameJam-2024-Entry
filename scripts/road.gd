extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func updateRoad(val: float):
	val *= 100
	if self.position.x <= -1400:
		self.position.x = 0
	self.position.x -= val
	# REPEATING ILLUSION
	
	
