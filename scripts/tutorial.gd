extends Node

var timer: Timer
var fadeBlack: ColorRect
var label: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $FadeOutTimer
	fadeBlack = $BlackFade
	label = $Label
	timer.start()
	$AnimationPlayer.play("fade_to_normal")
	get_tree().paused


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fade_out_timer_timeout():			# you can put something here
	pass # Replace with function body.
