extends CharacterBody3D

@export var look_sensitivity:float = 0.5
@export var speed:float = 10
@export var jump_strength:float = 10
@export var is_gravity_enabled:bool = true
@export var gravity:float = -9.81
var vertical_velocity:Vector3 = Vector3.ZERO

@onready var head:Node3D = $Head

var is_mouse_captured:bool:
	get:return Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	
# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$MeshInstance3D.visible = false

func _physics_process(delta):
	var horizontal_direction = global_transform.basis.z * Input.get_axis("move_forward","move_backward") +  global_transform.basis.x * Input.get_axis("move_left","move_right")
	
	if is_gravity_enabled:
		if not is_on_floor(): vertical_velocity.y += gravity * delta
		elif Input.is_action_just_pressed("jump"): vertical_velocity.y = jump_strength
		else: vertical_velocity.y = 0
		velocity = horizontal_direction.normalized() * speed + vertical_velocity
	else: velocity = (horizontal_direction + Vector3.UP * Input.get_axis("crouch","jump")).normalized() * speed
	
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if is_mouse_captured else Input.MOUSE_MODE_CAPTURED
	
	if is_mouse_captured:
		if event is InputEventMouseMotion:
			rotate_y(-deg2rad(event.relative.x))
			head.rotate_x(-deg2rad(event.relative.y))
			head.rotation.x = clamp(head.rotation.x,-90,90)
