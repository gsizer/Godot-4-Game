extends CharacterBody3D
class_name PlayerCharacter

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var Cam : Camera3D
@export var Collider : CollisionShape3D
@export var Model : MeshInstance3D

func _physics_process(delta):
	match self.motion_mode:
		MOTION_MODE_GROUNDED:
			# Add the gravity.
			if not is_on_floor():
				velocity.y -= gravity * delta
			# Handle Jump.
			if Input.is_action_just_pressed("move_jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
		MOTION_MODE_FLOATING:
			velocity.y = 0.0

func _input(event):
	if event.is_action_type():
		if event.is_action_pressed("move_left"):
			velocity.x -= 1 * SPEED
		if event.is_action_pressed("move_right"):
			velocity.x += 1 * SPEED
		if event.is_action_pressed("move_fore"):
			velocity.z -= 1 * SPEED
		if event.is_action_pressed("move_rear"):
			velocity.z += 1 * SPEED
		move_and_slide()

func save() -> Dictionary:
	var save_dict : Dictionary = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"position" : position
	}
	return save_dict
