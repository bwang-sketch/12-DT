extends RichTextLabel

var default_text = "Silence wraiths slain: "

#Displays player's current score
func _process(delta: float) -> void:
	var text = str(default_text, str(Global.current_score))
	self.text = (text)
