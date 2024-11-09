extends Node2D

var velocity = -800 # left

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(1280,640)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x < -50: queue_free()	# Free if out of bounds
	position += Vector2(velocity,0) * delta
	pass
