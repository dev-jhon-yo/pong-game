extends Node2D

@onready var ball: Area2D = $"../Ball"

# Sound Effect
@onready var sound_impact_goal: AudioStreamPlayer = $SoundImpactGoal

var player1_score: int = 0
var player2_score: int = 0

# UI
@onready var label_score_player1: Label = $"../UI/Scoreboard/ScorePlayer1"
@onready var label_score_player2: Label = $"../UI/Scoreboard/ScorePlayer2"


func _process(delta):
	receive_inputs()

func receive_inputs() -> void:
	# Restart the game
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	# Leave the game
	if Input.is_action_just_pressed("leave"):
		get_tree().quit()

func _on_goal_1_area_entered(area):
	sound_impact_goal.play()
	player2_score += 1
	label_score_player2.text = str(player2_score)
	ball.run_timer()

func _on_goal_2_area_entered(area):
	sound_impact_goal.play()
	player1_score += 1
	label_score_player1.text = str(player1_score)
	ball.run_timer()
