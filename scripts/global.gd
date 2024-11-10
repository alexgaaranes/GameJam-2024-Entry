extends Node


var bgm_player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	var bgm_stream = preload("res://assets/bgm-chill.mp3")
	bgm_player.stream = bgm_stream
	bgm_player.stream.loop = true
	bgm_player.play()
	bgm_player.volume_db = -25


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
