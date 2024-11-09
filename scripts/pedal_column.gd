extends Node2D

var detectedAreas: Dictionary # Append areas entered here

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
	detectedAreas["GB"] = area

func _on_great_area_front_area_entered(area):
	if area.get_name() != "AreaPedalCue": return
	detectedAreas["GF"] = area

func _on_perfect_area_area_entered(area):
	if area.get_name() != "AreaPedalCue": return
	detectedAreas["P"] = area

# EXIT
func _on_great_area_back_area_exited(area):
	detectedAreas.erase("GB")

func _on_great_area_front_area_exited(area):
	detectedAreas.erase("GF")

func _on_perfect_area_area_exited(area):
	detectedAreas.erase("P")
