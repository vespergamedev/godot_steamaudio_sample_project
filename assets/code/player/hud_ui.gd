extends Label

func _process(delta):
		text = "FPS: " + str(Engine.get_frames_per_second()) + "\n"
		text += "Hit G to play music"
