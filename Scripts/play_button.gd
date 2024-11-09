extends TextureButton

@onready var aplayer: AnimationPlayer = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aplayer.play("wiggle")


func _on_pressed() -> void:
	SceneManager.goto_scene("res://game.tscn")
