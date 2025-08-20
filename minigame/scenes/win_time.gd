extends Label

func _ready() -> void:
	text = "Time:" + str(SceneInfo.lost_timer.wait_time -SceneInfo.lost_timer.time_left) + " seconds"
