extends RigidBody



func _ready():
	pass # Replace with function body.

var force_applied = false
var countdown = 3


func _physics_process(delta):
	linear_damp = 0
	if not force_applied:
		__apply_forward_force(1, delta)
		force_applied = true
	if countdown > 0:
		print("delta = ", delta)

func _integrate_forces(state):
	if countdown > 0:
		print("vel = ", state.linear_velocity.length())
		print("ldamp = ", state.total_linear_damp)
		print()
		countdown -= 1
		
func __apply_forward_force(magnitude, delta):
	#var force = (Vector3.FORWARD * magnitude)
	#var rotation = Quat(self.rotation)
	#apply_central_impulse(rotation * force)
	#add_central_force(rotation * force / delta)
	apply_central_impulse(transform.basis.z * magnitude)

	
func _input(event):
	pass
