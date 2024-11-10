extends Node

var parent: Node
var root: Node
var gameOverScene: PackedScene
var cueSpawnManager: Node
var scoreManager: Node
var distanceManager: Node
var isGameOver: bool = false
var execOnce = true
var gameOverInstance: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	root = parent.get_parent()
	scoreManager = parent.get_node("ScoreManager")
	distanceManager = parent.get_node("DistanceManager")
	cueSpawnManager = parent.get_node("CueSpawnManager")
	gameOverScene = preload("res://scenes/game_over.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkHP()


func checkHP():
	var currHP = parent.getHP()
	if currHP <= 0:
		isGameOver = true
		if execOnce:
			execOnce = false
			cueSpawnManager.stopSpawn()
			gameOverInstance = gameOverScene.instantiate()
			gameOverInstance.setStats(scoreManager.getStats(),distanceManager.getDistance())
			root.add_child(gameOverInstance)

func getGameStatus():
	return isGameOver
