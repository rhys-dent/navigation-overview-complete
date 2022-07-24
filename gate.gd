extends StaticBody3D

@export var nav_region:NavigationRegion3D

func _input(event):
	if Input.is_key_pressed(KEY_G): 
		position.y = 8 if position.y == 0 else 0 
		nav_region.enabled = not position.y == 0
		
