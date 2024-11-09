extends Node2D

@onready var gameManagerNode: Node = get_node("/root/Main/GameManager")
@export var x_direction: int = -1
@export var y_direction: int = 0
@onready var myAnimationNode: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var Me = get_node("./.") as CharacterBody2D

var dying: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Me.is_in_group("Fish"):
		if x_direction > 0:
			myAnimationNode.flip_h = true
		elif x_direction < 0:
			myAnimationNode.flip_h = false
	if Me.is_in_group("Shark"):
		if x_direction > 0:
			myAnimationNode.flip_h = true
		elif x_direction < 0:
			myAnimationNode.flip_h = false

	myAnimationNode.play("Move")
	pass # Replace with function body.


# Called every frame. 'delta' is the selapsed time since the previous frame.
func _process(delta: float) -> void:
	if dying == true:
		return
		
	position.x += x_direction
	position.y += y_direction

	# Out of X bounds	
	if position.x < -600 or position.x > 1624:
		get_parent().remove_child(Me)
	# Out of Y Bounds
	if position.y < -600 or position.y > 1168:
		get_parent().remove_child(Me)

func _on_animated_sprite_2d_animation_finished() -> void:
	if myAnimationNode.animation.get_basename() != "Die":
		return
		
	gameManagerNode.creature_dying = false
	TicketManager.UpdateOdds()
	get_parent().remove_child(Me)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if dying == true:
		return
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		gameManagerNode.creature_dying = true
		dying = true
		myAnimationNode.play("Die")
		myAnimationNode.sprite_frames.set_animation_loop("Die", false)
		
		
