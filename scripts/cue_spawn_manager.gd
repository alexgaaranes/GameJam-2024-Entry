extends Node

var level: Node
var timer: Timer
var cueScene: PackedScene
var cueNode: Node
var parent: Node
var scoreManager: Node
var cyclistAnim: AnimatedSprite2D
var root: Node

const defaultTime = 1
var minSpawnTime = 0.4

var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_tree().get_root()
	parent = get_parent()
	root = parent.get_parent()
	cyclistAnim = root.get_node("Cyclist").get_node("AnimatedSprite2D")
	scoreManager = parent.get_node("ScoreManager")
	timer = get_node("CueSpawnTimer")
	cueScene = preload("res://scenes/pedal_cue.tscn")
	timer.wait_time = 4
	timer.start()
	timer.wait_time = defaultTime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(timer.wait_time)
	pass
	

func _on_cue_spawn_timer_timeout():
	cueNode = cueScene.instantiate()
	cueNode.setVelocity(-600-600*0.1*scoreManager.getMultiplier())
	level.add_child(cueNode)
	timer.start()

func reduceTime(amount: float):
	#TODO: MID ANIMATION
	#if timer.wait_time < minSpawnTime + 0.2:	# UNCOMMENT TO USE
		# PUT MID SPEED ANIMATION HERE
	
	if timer.wait_time < minSpawnTime:
		if not played:
			$"PowerUpSFX".play()
			played = true
		cyclistAnim.stop()
		cyclistAnim.play("fast_moving")
		return
	else:
		played = false
		
	timer.wait_time -= timer.wait_time*amount
	
func resetTime():
	timer.wait_time = defaultTime

func stopSpawn():
	if timer.wait_time > 0:
		timer.stop()
