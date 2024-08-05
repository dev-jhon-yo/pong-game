extends Area2D

# Movement
var ball_speed: int = 500
var initial_position: Vector2 = Vector2(640, 360)
var initial_direction: Vector2 = Vector2(0, 0)
var new_direction: Vector2 = Vector2(0, 0)

# Limits
var x_min: float = 0
var x_max: float = 1280
var y_min: float = 0
var y_max: float = 720

@onready var sound_impact_barrier: AudioStreamPlayer = $SoundImpactBarrier
@onready var sound_impact_player: AudioStreamPlayer = $SoundImpactPlayer

@onready var timer: Timer = $Timer

func _ready():
	run_timer()

func _process(delta):
	move_ball(delta)
	collide_with_walls()

func run_timer() -> void:
	timer.start() 

func reset_ball() -> void:
	# Center the ball and sends it in a random direction
	position = initial_position
	choose_initial_direction()

func choose_initial_direction() -> void:
	# Choose Horizontal and Vertical direction
	var x_random = [-1, 1].pick_random()
	var y_random = [-1, 1].pick_random()
	
	# Apply new direction
	initial_direction = Vector2(x_random, y_random)
	new_direction = initial_direction

func move_ball(delta: float) -> void:
	position += new_direction * ball_speed * delta

func collide_with_walls() -> void:
	# Send the ball in the opposite direction when colliding with walls
	if position.y >= y_max or position.y <= y_min:
		if position.x >= x_min and position.x <= x_max:
			new_direction.y *= -1
			sound_impact_barrier.play()

func _on_body_entered(body):
	# Send the ball in the opposite direction when colliding with players
	if body.is_in_group("players"):
		new_direction.x *= -1
		sound_impact_player.play()

func _on_timer_timeout():
	reset_ball()
