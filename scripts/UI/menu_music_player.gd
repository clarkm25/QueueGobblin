extends Node

var menu_music : PackedScene = preload("res://scenes/menus/menu_audio.tscn")
var music
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music = menu_music.instantiate()
	add_child(music)
