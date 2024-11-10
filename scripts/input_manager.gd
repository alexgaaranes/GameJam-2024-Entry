extends Node

var pedalColumn: Node2D
var pedalColumnAnim: AnimationPlayer
var label: Label
var parent: Node
var timer: Timer
var root: Node

var isPenalized: bool
var hasMissed: bool = true
var detected: Dictionary
var passedCues: Array
var scoreManager: Node
var damageColor: ColorRect
var gameOverManager: Node
var cyclist: Area2D
var cyclistAnim: AnimatedSprite2D
var penaltyColour: ColorRect

var bgmIsPlayed: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	root = parent.get_parent()
	cyclist = root.get_node("Cyclist")
	cyclistAnim = cyclist.get_node("AnimatedSprite2D")
	gameOverManager = parent.get_node("GameOverManager")
	scoreManager = parent.get_node("ScoreManager")
	pedalColumn = parent.get_parent().get_node("PedalColumn")
	pedalColumnAnim = pedalColumn.get_node("AnimationPlayer")
	label = get_parent().get_parent().get_node("Label")
	damageColor = root.get_node("DamageColor")
	damageColor.visible = false
	isPenalized = false
	penaltyColour = root.get_node("PedalColumn").get_node("PenaltyColour")
	penaltyColour.visible = false
	timer = get_node("PenaltyTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gameOverManager.getGameStatus():
		return
	if not pedalColumnAnim.is_playing():
		pedalColumnAnim.play("idle")
	# Pedal Action
	if (Input.is_action_just_pressed("pedal") or Input.is_action_just_pressed("tap")) and not isPenalized:
		if not bgmIsPlayed:
			Global.bgm_player.stop()
			parent.get_node("BGM").play()
			bgmIsPlayed = true
		pedalColumnAnim.play("tap")
		detected = pedalColumn.detectedAreas
		root.get_node("InputSFX").play()
		if not detected.is_empty():
			if hasMissed:
				hasMissed = false
				cyclistAnim.stop()
				cyclistAnim.play("moving")
			if detected.has("P"):
				updateLabel("Perfect")
				await scoreManager.addPerfect(1)
			else:
				updateLabel("Great")
				await scoreManager.addGreat(1)
			scoreManager.updateCombo()
			detected.values()[0].free()
		else:
			cyclistAnim.stop()
			cyclistAnim.play("slowing")
			updateLabel("Miss")
			await scoreManager.addMissed(1)
			isPenalized = true
			penaltyColour.visible = true
			
			hasMissed = true
			damageColor.visible = true
			timer.start()
			root.get_node("HurtSFX").play()
		
	clearPassed()

# OTHER FUNCTIONS
func _on_penalty_timer_timeout():
	isPenalized = false
	damageColor.visible = false
	penaltyColour.visible = false

# function for clearing cues that passed
func clearPassed():
	passedCues = pedalColumn.passedCues
	if passedCues.is_empty(): return
	for cue in passedCues:
		passedCues.erase(cue)
		if cue == null: continue
		updateLabel("Miss")
		await scoreManager.addMissed(1)
		isPenalized = true
		damageColor.visible = true
		timer.start()
		cue.free()
		root.get_node("HurtSFX").play()
		penaltyColour.visible = true

# SUPPLEMENTARY FUNCTIONS
func updateLabel(text: String):
	var color: Color
	if text == "Perfect":
		color = Color(0.8,0.5,0)
	elif text == "Great":
		color = Color(0.05,0.4,0.1)
	else:
		color = Color(0.6,0.1,0.1)
		
	label.add_theme_color_override("font_color", color)
	label.text = "%s" % [text]
