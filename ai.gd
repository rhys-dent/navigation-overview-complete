extends Node3D


@export var target_location:Node3D

@onready var nav_agent = $NavigationAgent3D
 
 
func _ready():
	nav_agent.set_target_location(target_location.global_position)
	
	
	
func _physics_process(delta):
	if nav_agent.is_target_reachable() and not nav_agent.is_target_reached():
		var next_location = nav_agent.get_next_location()
		var direction = global_position.direction_to(next_location)
		global_position += direction * delta
