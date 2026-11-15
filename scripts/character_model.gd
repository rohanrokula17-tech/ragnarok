extends Node3D

@export var primary_color := Color(0.08, 0.24, 0.32)
@export var accent_color := Color(0.1, 0.8, 0.92)
@export var include_weapon := false

var primary_material: StandardMaterial3D
var accent_material: StandardMaterial3D
var dark_material: StandardMaterial3D
var joint_material: StandardMaterial3D
var left_arm_pivot: Node3D
var right_arm_pivot: Node3D
var left_leg_pivot: Node3D
var right_leg_pivot: Node3D
var walk_phase := 0.0


func _ready():
	primary_material = _make_material(primary_color, 0.28)
	accent_material = _make_material(accent_color, 0.5, true)
	dark_material = _make_material(Color(0.035, 0.055, 0.075), 0.42)
	joint_material = _make_material(Color(0.11, 0.14, 0.17), 0.32)
	_build_model()


func _build_model():
	# Armored torso and back pack.
	_add_box(self, "TorsoArmor", Vector3(0.68, 0.76, 0.42), Vector3(0, 1.18, 0), primary_material)
	_add_box(self, "ChestPlate", Vector3(0.48, 0.34, 0.08), Vector3(0, 1.34, -0.245), accent_material)
	_add_box(self, "Belt", Vector3(0.6, 0.16, 0.43), Vector3(0, 0.77, 0), dark_material)
	_add_box(self, "BackPack", Vector3(0.46, 0.52, 0.24), Vector3(0, 1.18, 0.31), dark_material)
	_add_box(self, "BackPackLight", Vector3(0.22, 0.12, 0.035), Vector3(0, 1.29, 0.445), accent_material)

	# Helmet and opaque visor keep the models readable from the game camera.
	_add_sphere(self, "Helmet", 0.29, 0.52, Vector3(0, 1.86, 0), primary_material)
	_add_box(self, "Visor", Vector3(0.37, 0.13, 0.055), Vector3(0, 1.88, -0.255), dark_material)
	_add_box(self, "VisorGlow", Vector3(0.25, 0.035, 0.025), Vector3(0, 1.88, -0.29), accent_material)

	# Shoulder pads and articulated arms.
	_add_sphere(self, "LeftShoulder", 0.2, 0.36, Vector3(-0.43, 1.47, 0), accent_material)
	_add_sphere(self, "RightShoulder", 0.2, 0.36, Vector3(0.43, 1.47, 0), accent_material)
	left_arm_pivot = _make_limb_pivot("LeftArmPivot", Vector3(-0.43, 1.42, 0))
	right_arm_pivot = _make_limb_pivot("RightArmPivot", Vector3(0.43, 1.42, 0))
	_add_capsule(left_arm_pivot, "LeftArm", 0.13, 0.62, Vector3(0, -0.31, 0), primary_material)
	_add_capsule(right_arm_pivot, "RightArm", 0.13, 0.62, Vector3(0, -0.31, 0), primary_material)
	_add_box(left_arm_pivot, "LeftGlove", Vector3(0.22, 0.16, 0.22), Vector3(0, -0.62, -0.035), dark_material)
	_add_box(right_arm_pivot, "RightGlove", Vector3(0.22, 0.16, 0.22), Vector3(0, -0.62, -0.035), dark_material)

	# Legs and boots.
	left_leg_pivot = _make_limb_pivot("LeftLegPivot", Vector3(-0.2, 0.68, 0))
	right_leg_pivot = _make_limb_pivot("RightLegPivot", Vector3(0.2, 0.68, 0))
	_add_capsule(left_leg_pivot, "LeftLeg", 0.16, 0.7, Vector3(0, -0.34, 0), primary_material)
	_add_capsule(right_leg_pivot, "RightLeg", 0.16, 0.7, Vector3(0, -0.34, 0), primary_material)
	_add_box(left_leg_pivot, "LeftBoot", Vector3(0.31, 0.17, 0.43), Vector3(0, -0.69, -0.055), dark_material)
	_add_box(right_leg_pivot, "RightBoot", Vector3(0.31, 0.17, 0.43), Vector3(0, -0.69, -0.055), dark_material)
	_add_box(left_leg_pivot, "LeftKneePad", Vector3(0.23, 0.2, 0.08), Vector3(0, -0.16, -0.17), accent_material)
	_add_box(right_leg_pivot, "RightKneePad", Vector3(0.23, 0.2, 0.08), Vector3(0, -0.16, -0.17), accent_material)

	if include_weapon:
		_add_box(self, "RifleBody", Vector3(0.16, 0.17, 0.58), Vector3(0.37, 1.1, -0.43), dark_material)
		_add_box(self, "RifleBarrel", Vector3(0.07, 0.07, 0.38), Vector3(0.37, 1.11, -0.9), joint_material)
		_add_box(self, "RifleStock", Vector3(0.2, 0.2, 0.23), Vector3(0.37, 1.1, -0.05), joint_material)
		_add_box(self, "RifleSight", Vector3(0.09, 0.1, 0.18), Vector3(0.37, 1.23, -0.47), accent_material)


func _make_limb_pivot(pivot_name: String, pivot_position: Vector3) -> Node3D:
	var pivot = Node3D.new()
	pivot.name = pivot_name
	pivot.position = pivot_position
	add_child(pivot)
	return pivot


func _add_box(parent: Node3D, part_name: String, size: Vector3, part_position: Vector3, material: Material):
	var mesh = BoxMesh.new()
	mesh.size = size
	_add_mesh(parent, part_name, mesh, part_position, material)


func _add_capsule(parent: Node3D, part_name: String, radius: float, height: float, part_position: Vector3, material: Material):
	var mesh = CapsuleMesh.new()
	mesh.radius = radius
	mesh.height = height
	_add_mesh(parent, part_name, mesh, part_position, material)


func _add_sphere(parent: Node3D, part_name: String, radius: float, height: float, part_position: Vector3, material: Material):
	var mesh = SphereMesh.new()
	mesh.radius = radius
	mesh.height = height
	_add_mesh(parent, part_name, mesh, part_position, material)


func _add_mesh(parent: Node3D, part_name: String, mesh: Mesh, part_position: Vector3, material: Material):
	var part = MeshInstance3D.new()
	part.name = part_name
	part.mesh = mesh
	part.position = part_position
	part.material_override = material
	parent.add_child(part)


func _make_material(color: Color, metallic_value: float, glowing := false) -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	material.metallic = metallic_value
	material.roughness = 0.48
	if glowing:
		material.emission_enabled = true
		material.emission = color * 0.22
	return material


func _process(delta):
	var actor = get_parent() as CharacterBody3D
	if actor == null or left_leg_pivot == null:
		return

	var planar_speed = Vector2(actor.velocity.x, actor.velocity.z).length()
	var walking = actor.is_on_floor() and planar_speed > 0.15
	var swing := 0.0
	if walking:
		walk_phase += delta * (6.0 + planar_speed * 0.28)
		swing = sin(walk_phase) * minf(planar_speed / 6.0, 1.0) * 0.42

	left_leg_pivot.rotation.x = move_toward(left_leg_pivot.rotation.x, swing, delta * 7.0)
	right_leg_pivot.rotation.x = move_toward(right_leg_pivot.rotation.x, -swing, delta * 7.0)
	if include_weapon:
		left_arm_pivot.rotation.x = move_toward(left_arm_pivot.rotation.x, -0.2 - swing * 0.25, delta * 7.0)
		right_arm_pivot.rotation.x = move_toward(right_arm_pivot.rotation.x, -0.35 + swing * 0.12, delta * 7.0)
	else:
		left_arm_pivot.rotation.x = move_toward(left_arm_pivot.rotation.x, -swing, delta * 7.0)
		right_arm_pivot.rotation.x = move_toward(right_arm_pivot.rotation.x, swing, delta * 7.0)
