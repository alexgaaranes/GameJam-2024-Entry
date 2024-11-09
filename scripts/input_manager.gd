extends Node

var pedalColumn: Node2D
var detected: Dictionary
var label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pedalColumn = get_parent().get_parent().get_node("PedalColumn")
	label = get_parent().get_parent().get_node("Label")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Detection debugging print
	if not pedalColumn.detectedAreas.is_empty():
		print(pedalColumn.detectedAreas)
	
	# Pedal Action
	if Input.is_action_just_pressed("pedal"):
		detected = pedalColumn.detectedAreas
		if not detected.is_empty():
			if detected.has("P"):
				label.text = "Last Cue: Perfect"
			else:
				label.text = "Last Cue: Great"
			detected.values()[0].queue_free()
		else:
			label.text = "Last Cue: Missed"
