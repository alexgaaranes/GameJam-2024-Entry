extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func updateRoad(val: float):
	val *= 100
	if $RoadTiles1.position.x - val <= -1400:
		$RoadTiles1.position.x = 1400
	if $RoadTiles2.position.x - val<= -1400:
		$RoadTiles2.position.x = 1400
	$RoadTiles1.position.x -= val
	$RoadTiles2.position.x -= val
	# REPEATING ILLUSION
	
	
