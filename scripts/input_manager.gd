extends Node

var pedalColumn: Node2D
var label: Label
var parent: Node
var timer: Timer

var isPenalized: bool
var detected: Dictionary
var passedCues: Array

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
	#if not pedalColumn.detectedAreas.is_empty():
		#print(pedalColumn.detectedAreas)
	
	# Pedal Action
	if Input.is_action_just_pressed("pedal") and not isPenalized:
		detected = pedalColumn.detectedAreas
		if not detected.is_empty():
			if detected.has("P"):
				updateLabel("Perfect")
				await parent.addPerfect(1)
			else:
				updateLabel("Great")
				await parent.addGreat(1)
			parent.updateCombo()
			detected.values()[0].queue_free()
		else:
			updateLabel("Missed")
			await parent.addMissed(1)
			parent.resetCombo()
			isPenalized = true
			timer.start()
		
	clearPassed()

# OTHER FUNCTIONS
func _on_penalty_timer_timeout():
	isPenalized = false

# function for clearing cues that passed
func clearPassed():
	passedCues = pedalColumn.passedCues
	print(passedCues)
	if passedCues.is_empty(): return
	for cue in passedCues:
		passedCues.erase(cue)
		if cue == null: continue
		parent.addMissed(1)
		cue.queue_free()

# SUPPLEMENTARY FUNCTIONS
func updateLabel(text: String):
	label.text = "Last Cue: %s" % [text]
