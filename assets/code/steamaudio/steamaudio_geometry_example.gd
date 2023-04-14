extends SteamAudioGeometry

# Called when the node enters the scene tree for the first time.
func _ready():

	var mesh = get_parent().mesh
	self.create_geometry(mesh,self.global_transform)
	self.register_geometry()

	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
