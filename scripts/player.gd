extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var hit = $Hit

const SPEED = 100.0
const JUMP_VELOCITY = -280.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hp = 3
var is_alive = true

func handle_hit(damage: int):
	hit.play()
	hp += damage
	game_manager.update_health(hp)
	if hp == 0:
		handle_death()

func handle_death():
	hp = 0
	is_alive = false
	animated_sprite.play("death")
	game_manager.display_game_over()

@onready var jump = $Jump

func _physics_process(delta):
	
	if is_alive:
			# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump.play()
			velocity.y = JUMP_VELOCITY

		# Get the input direction: -1, 0, 1
		var direction = Input.get_axis("move_left", "move_right")
		
		# Apply movement
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Flip the sprite
		if direction > 0:
			animated_sprite.flip_h = false	
		elif direction < 0:
			animated_sprite.flip_h = true
			
		# Play animations
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		
		move_and_slide()
