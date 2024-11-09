extends Node2D

var detectedAreas: Dictionary # Append areas entered here
var passedCues: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# AREA NODE SIGNALS
# ENTER
func _on_great_area_back_area_entered(area):
	if area.get_name() != "AreaPedalCue": return
	detectedAreas["GB"] = area.get_parent()

func _on_great_area_front_area_entered(area):
	if area.get_name() != "AreaPedalCue": return
	detectedAreas["GF"] = area.get_parent()

func _on_perfect_area_area_entered(area):
	if area.get_name() != "AreaPedalCue": return
	detectedAreas["P"] = area.get_parent()

# EXIT
func _on_great_area_back_area_exited(area):
	detectedAreas.erase("GB")

func _on_great_area_front_area_exited(area):
	detectedAreas.erase("GF")

func _on_perfect_area_area_exited(area):
	detectedAreas.erase("P")

# END POINT
func _on_end_area_area_entered(area):
	passedCues.append(area.get_parent())
