extends Node
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func play_music():
	audio_stream_player.play()
	
func stop_music():
	audio_stream_player.stop()
