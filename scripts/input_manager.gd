extends Node

var pedalColumn: Node2D
var pedalColumnAnim: AnimationPlayer
var label: Label
var parent: Node
var timer: Timer

var isPenalized: bool
var detected: Dictionary
var passedCues: Array
var scoreManager: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	scoreManager = parent.get_node("ScoreManager")
	pedalColumn = parent.get_parent().get_node("PedalColumn")
	pedalColumnAnim = pedalColumn.get_node("AnimationPlayer")
	label = get_parent().get_parent().get_node("Label")
	isPenalized = false
	timer = get_node("PenaltyTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not pedalColumnAnim.is_playing():
		pedalColumnAnim.play("idle")
	# Pedal Action
	if Input.is_action_just_pressed("pedal") and not isPenalized:
		pedalColumnAnim.play("tap")
		detected = pedalColumn.detectedAreas
		if not detected.is_empty():
			if detected.has("P"):
				updateLabel("Perfect")
				await scoreManager.addPerfect(1)
			else:
				updateLabel("Great")
				await scoreManager.addGreat(1)
			scoreManager.updateCombo()
			detected.values()[0].free()
		else:
			updateLabel("Missed")
			await scoreManager.addMissed(1)
			isPenalized = true
			timer.start()
		
	clearPassed()

# OTHER FUNCTIONS
func _on_penalty_timer_timeout():
	isPenalized = false

# function for clearing cues that passed
func clearPassed():
	passedCues = pedalColumn.passedCues
	if passedCues.is_empty(): return
	for cue in passedCues:
		passedCues.erase(cue)
		if cue == null: continue
		scoreManager.addMissed(1)
		cue.free()

# SUPPLEMENTARY FUNCTIONS
func updateLabel(text: String):
	label.text = "%s" % [text]
