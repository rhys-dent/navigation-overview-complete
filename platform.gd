extends StaticBody3D


func _input(event):
	if Input.is_key_pressed(KEY_P): position.y = 8 if position.y == 0 else 0 
	
