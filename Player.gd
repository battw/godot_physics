extends KinematicBody

export var speed = 10
export var g = 30
export var look_speed = 0.005

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var local_velocity = (Vector3.FORWARD * (Input.get_action_strength("forward") - Input.get_action_strength("backward"))
				 + Vector3.LEFT * (Input.get_action_strength("left") - Input.get_action_strength("right")))
	var global_velocity = local_velocity.rotated(Vector3.UP, rotation.y)
	move_and_slide(speed * global_velocity + Vector3.DOWN * g)

func _input(event):
	if event is InputEventMouseMotion:
		assert($Camera != null)
		rotate_y(-event.relative.x * look_speed)
		$Camera.rotate_x(-event.relative.y * look_speed)

	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)