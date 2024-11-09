extends Node2D

var velocity = -500 # left

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(1280,640)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(velocity,0) * delta
	pass
