extends Label

var default_text = "High score: "

#Displays player's current score
func _process(delta: float) -> void:
	var text = str(default_text, str(Global.high_score))
	self.text = (text)
