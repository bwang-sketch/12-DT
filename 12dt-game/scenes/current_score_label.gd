extends Label

var default_text = "Silence wraiths slain: "

func _process(delta: float) -> void:
	var text = str(default_text, str(Global.current_score))
	self.text = (text)
