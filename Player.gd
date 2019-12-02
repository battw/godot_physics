extends KinematicBody

export var speed = 10.0
export var g = 1.0
export var terminal_velocity = 500.0
var vert_speed = 0.0

export var mouse_look_speed = 0.005
export var joy_look_speed = 5

func _ready():
	assert($Camera != null)
	assert($CollisionShape != null)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var local_heading = (Vector3.FORWARD * (Input.get_action_strength("forward") - Input.get_action_strength("backward"))
				 + Vector3.LEFT * (Input.get_action_strength("left") - Input.get_action_strength("right")))

	# if digital input then normalise
	if local_heading.length() > 1:
		local_heading = local_heading.normalized()

	var global_heading = local_heading.rotated(Vector3.UP, rotation.y)
	if is_on_floor():
		vert_speed = 0.0
	else:
		vert_speed += g * delta
	move_and_slide(global_heading * speed + Vector3.DOWN * vert_speed, Vector3.UP)

	var y_rot = joy_look_speed * (Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right"))
	rotate_y(y_rot * delta)
	var x_rot = joy_look_speed * (Input.get_action_strength("look_up") - Input.get_action_strength("look_down"))
	$Camera.rotate_x(x_rot * delta)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_look_speed)
		$Camera.rotate_x(-event.relative.y * mouse_look_speed)



	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)