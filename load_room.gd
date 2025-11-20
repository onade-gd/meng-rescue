extends Control
var next_scene = "res://mainscreen/Main.tscn"
func _ready() -> void:
	ResourceLoader.load_threaded_request(next_scene)
	if StageResource.health == true:
		PlayerprogressSavefile.booster_heart["count"] -= 1
	if StageResource.invincible == true:
		PlayerprogressSavefile.booster_invincible["count"] -= 1
	if StageResource.magnet == true:
		PlayerprogressSavefile.booster_magnet["count"] -= 1

func _physics_process(delta: float) -> void:
	if ResourceLoader.load_threaded_get_status(next_scene) == ResourceLoader.THREAD_LOAD_LOADED:
		var load_next_scene = ResourceLoader.load_threaded_get(next_scene).instantiate()
		get_tree().root.add_child(load_next_scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = load_next_scene
