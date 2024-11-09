extends Node

var pedalColumn: Node2D
var label: Label
var parent: Node
var timer: Timer

var isPenalized: bool
var detected: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pedalColumn = parent.get_parent().get_node("PedalColumn")
	label = get_parent().get_parent().get_node("Label")
	isPenalized = false
	timer = get_node("PenaltyTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Detection debugging print
	if not pedalColumn.detectedAreas.is_empty():
		print(pedalColumn.detectedAreas)
	
	# Pedal Action
	if Input.is_action_just_pressed("pedal") and not isPenalized:
		detected = pedalColumn.detectedAreas
		if not detected.is_empty():
			if detected.has("P"):
				updateLabel("Perfect")
				parent.perfectAmt += 1
			else:
				updateLabel("Great")
				parent.greatAmt += 1
			detected.values()[0].queue_free()
		else:
			updateLabel("Missed")
			parent.missedAmt += 1
			isPenalized = true
			timer.start()

func _on_penalty_timer_timeout():
	isPenalized = false


# SUPPLEMENTARY FUNCTIONS
func updateLabel(text: String):
	label.text = "Last Cue: %s" % [text]
