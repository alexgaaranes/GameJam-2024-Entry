extends Node2D

var velocity = -1000 # left

var root: Node
var gameManager: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_parent()
	position = Vector2(1280,640)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(velocity,0) * delta
