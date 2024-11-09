extends CharacterBody2D

@onready var GameManager = get_node("/root/Main/GameManager")
@onready var Me = get_node("./.") as CharacterBody2D
@onready var APlayer: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	APlayer.play("Wiggle")

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if GameManager.creature_dying == true:
		return
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		SceneManager.goto_scene("res://win.tscn")
