extends AudioStreamPlayerSteamAudio

@onready var stream_pb : AudioStreamPlaybackSteamAudio
@onready var mysound : AudioStreamMP3 = preload("res://assets/audio/lone-wolf-10374.mp3")

func _ready():
	play()
	var success = init_source_steamaudio()
	print("Source Initialized?" + str(success))
	stream_pb = get_stream_playback()


func _process(delta):
	pass

func _physics_process(delta):
	#hit the "G" key
	if Input.is_action_just_pressed("play_music"):
		var rt = 0
		rt = stream_pb.play_stream(mysound)
		print("Playing stream " + str(rt))
