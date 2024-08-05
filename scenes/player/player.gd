extends StaticBody2D

@export var playerOne: bool
var player_speed: int = 500

# Limits
var y_min: float = 64
var y_max: float = 654

func _process(delta):
	move_player(delta)
	limit_player_move()

func move_player(delta: float) -> void:
	# Movement player 1
	if playerOne:
		if Input.is_action_pressed("move-up-playerOne"):
			position.y -= player_speed * delta
		elif Input.is_action_pressed("move-down-playerOne"):
			position.y += player_speed * delta
	# Movement player 2
	else:
		if Input.is_action_pressed("move-up-playerTwo"):
			position.y -= player_speed * delta
		elif Input.is_action_pressed("move-down-playerTwo"):
			position.y += player_speed * delta

func limit_player_move() -> void:
	# Prevents the player from leaving the screen
	position.y = clamp(position.y, y_min, y_max)
