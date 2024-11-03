extends Area2D

@export var item_resource : InventoryItem
var inventory : Inventory
@onready var sprite : Sprite2D = $Sprite2D
@onready var label : Label = $ItemLabel

# max contributed a newline here ^

var pickupable : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var item_texture = item_resource.texture
	sprite.texture = item_texture
	inventory = get_tree().get_first_node_in_group("inventory").inventory
	label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_glow()
		pickupable = true
		
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("interact"):
		if pickupable && !inventory.is_full():
			inventory.add_item(item_resource)
			queue_free()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_unglow()
		pickupable = false
		
func _glow():
	# material applied to sprite2d node glows;
	# so setting use_parent_material to false uses the material that glows.
	sprite.use_parent_material = false
	label.text = item_resource.name + " E to pick up"
	label.show()
	
func _unglow():
	sprite.use_parent_material = true
	label.hide()

	
