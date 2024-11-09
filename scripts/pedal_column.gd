extends Node2D

var detectedAreas: Array # Append areas entered here

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_great_area_back_area_entered(area):
	detectedAreas.append("Great_B")

func _on_great_area_front_area_entered(area):
	detectedAreas.append("Great_F")

func _on_perfect_area_area_entered(area):
	detectedAreas.append("Perfect")
