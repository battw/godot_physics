extends RigidBody

func _ready():
	assert($MeshInstance != null)
	assert($MeshInstance.mesh != null)
	assert($CollisionShape != null)

	var faces = $MeshInstance.mesh.get_faces()
	$CollisionShape.shape.set_faces(faces)
#	$CollisionShape.shape = $MeshInstance.mesh.create_convex_shape()



