extends Control

@export var SelectedGame : int
@export var SaveDataList : ItemList
@export var AmbientVolumeSlider : HSlider
@export var EffectsVolumeSlider : HSlider
@export var MainVolumeSlider : HSlider
@export var MusicVolumeSlider : HSlider
@export var VoiceVolumeSlider : HSlider
@export var WeatherVolumeSlider : HSlider
@export var EnableReflections : CheckBox
@export var EnableAmbientOcclusion : CheckBox
@export var EnableIndirectLighting : CheckBox
@export var EnableGlobalIllumination : CheckBox
@export var EnableGlow : CheckBox
@export var EnableFog : CheckBox
@export var EnableColorAdjust : CheckBox
@export var BrightnessSlider : HSlider
@export var ContrastSlider : HSlider
@export var SaturationSlider : HSlider

################################################################################
const _configFile : String = "user://config.ini"
const _saveData : String = "user://data/"
const _newSaveGame : String = "res://scenes/new_game.tscn"
var CTRL : Controller
var ENV := Environment.new()
var CFG : ConfigFile
var _SaveGame : String = ""

################################################################################
func _writeDefaults()->void:
	CFG.clear()
	CFG.set_value("Audio", "Ambient", 0.0)
	CFG.set_value("Audio", "Effects", 0.0)
	CFG.set_value("Audio", "Main", 0.0)
	CFG.set_value("Audio", "Music", 0.0)
	CFG.set_value("Audio", "Voice", 0.0)
	CFG.set_value("Audio", "Weather", 0.0)
	CFG.set_value("Environment", "ssr_enabled", false)
	CFG.set_value("Environment", "ssao_enabled", false)
	CFG.set_value("Environment", "ssil_enabled", false)
	CFG.set_value("Environment", "sdfgi_enabled", false)
	CFG.set_value("Environment", "glow_enabled", false)
	CFG.set_value("Environment", "fog_enabled", false)
	CFG.set_value("Environment", "adjustment_enabled", false)
	CFG.set_value("Environment", "adjustment_brightness", 1.0)
	CFG.set_value("Environment", "adjustment_contrast", 1.0)
	CFG.set_value("Environment", "adjustment_saturation", 1.0)
	CFG.save(_configFile)

func _updateConfig()->void:
	CFG.set_value("Audio", "Ambient", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Ambient")))
	CFG.set_value("Audio", "Effects", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects")))
	CFG.set_value("Audio", "Main", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	CFG.set_value("Audio", "Music", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	CFG.set_value("Audio", "Voice", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Voice")))
	CFG.set_value("Audio", "Weather", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Weather")))
	CFG.set_value("Environment", "ssr_enabled", ENV.ssr_enabled)
	CFG.set_value("Environment", "ssao_enabled", ENV.ssao_enabled)
	CFG.set_value("Environment", "ssil_enabled", ENV.ssil_enabled)
	CFG.set_value("Environment", "sdfgi_enabled", ENV.sdfgi_enabled)
	CFG.set_value("Environment", "glow_enabled", ENV.glow_enabled)
	CFG.set_value("Environment", "fog_enabled", ENV.fog_enabled)
	CFG.set_value("Environment", "adjustment_enabled", ENV.adjustment_enabled)
	CFG.set_value("Environment", "adjustment_brightness", ENV.adjustment_brightness)
	CFG.set_value("Environment", "adjustment_contrast", ENV.adjustment_contrast)
	CFG.set_value("Environment", "adjustment_saturation", ENV.adjustment_saturation)

func _applyConfig()->void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient") , CFG.get_value("Audio", "Ambient", -45) )
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects") , CFG.get_value("Audio", "Effects", -10) )
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master") , CFG.get_value("Audio", "Main", -30) )
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music") , CFG.get_value("Audio", "Music", -40) )
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice") , CFG.get_value("Audio", "Voice", -20) )
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Weather") , CFG.get_value("Audio", "Weather", -50) )
	ENV.ssr_enabled = CFG.get_value("Environment", "ssr_enabled",  false)
	ENV.ssao_enabled = CFG.get_value("Environment", "ssao_enabled", false)
	ENV.ssil_enabled = CFG.get_value("Environment", "ssil_enabled", false)
	ENV.sdfgi_enabled = CFG.get_value("Environment", "sdfgi_enabled", false)
	ENV.glow_enabled = CFG.get_value("Environment", "glow_enabled", false)
	ENV.fog_enabled = CFG.get_value("Environment", "fog_enabled", false)
	ENV.adjustment_enabled = CFG.get_value("Environment", "adjustment_enabled", false)
	ENV.adjustment_brightness = CFG.get_value("Environment", "adjustment_brightness", 1.0)
	ENV.adjustment_contrast = CFG.get_value("Environment", "adjustment_contrast", 1.0)
	ENV.adjustment_saturation = CFG.get_value("Environment", "adjustment_saturation", 1.0)

func _saveConfig()->void:
	CFG.save(_configFile)

func _loadConfig()->void:
	CFG = ConfigFile.new()
	var err = CFG.load(_configFile)
	if err != OK: _writeDefaults()
	CFG.load(_configFile)

################################################################################
# Apply options from ConfigFile to GUI
func _updateGUI()->void:
	#	Audio Sliders
	AmbientVolumeSlider.set_value_no_signal( CFG.get_value("Audio", "Ambient", -80.0) )
	EffectsVolumeSlider.set_value_no_signal( CFG.get_value("Audio", "Effects", -80.0) )
	MainVolumeSlider.set_value_no_signal( CFG.get_value("Audio", "Main", -80.0) )
	MusicVolumeSlider.set_value_no_signal( CFG.get_value("Audio", "Music", -80.0) )
	VoiceVolumeSlider.set_value_no_signal( CFG.get_value("Audio", "Voice", -80.0) )
	WeatherVolumeSlider.set_value_no_signal( CFG.get_value("Audio", "Weather", -80.0) )
	#	Video Options
	EnableReflections.set_pressed_no_signal( CFG.get_value("Environment", "ssr_enabled", false) )
	EnableAmbientOcclusion.set_pressed_no_signal( CFG.get_value("Environment", "ssao_enabled", false) )
	EnableIndirectLighting.set_pressed_no_signal( CFG.get_value("Environment", "ssil_enabled", false) )
	EnableGlobalIllumination.set_pressed_no_signal( CFG.get_value("Environment", "sdfgi_enabled", false) )
	EnableGlow.set_pressed_no_signal( CFG.get_value("Environment", "glow_enabled", false) )
	EnableFog.set_pressed_no_signal( CFG.get_value("Environment", "fog_enabled", false) )
	EnableColorAdjust.set_pressed_no_signal( CFG.get_value("Environment", "adjustment_enabled", false) )
	if CFG.get_value("Environment", "adjustment_enabled", false):
		BrightnessSlider.editable = true
		ContrastSlider.editable = true
		SaturationSlider.editable = true
		BrightnessSlider.set_value_no_signal( CFG.get_value("Environment", "adjustment_brightness", 1.0) )
		ContrastSlider.set_value_no_signal( CFG.get_value("Environment", "adjustment_contrast", 1.0) )
		SaturationSlider.set_value_no_signal( CFG.get_value("Environment", "adjustment_saturation", 1.0) )
	else:
		BrightnessSlider.editable = false
		ContrastSlider.editable = false
		SaturationSlider.editable = false

################################################################################
#	Main Panel
func _on_game_pressed():
	$Main.hide()
	$Game.show()

func _on_audio_pressed():
	$Main.hide()
	$Audio.show()

func _on_video_pressed():
	$Main.hide()
	$Video.show()

func _on_quit_pressed():
	$Main.hide()
	$Quit.show()

################################################################################
#	Game List Panel
func _on_game_visibility_changed():
	if $Game.is_visible_in_tree():
		# list files in Save Data Dir
		var dir = DirAccess.open(_saveData)
		if dir:
			SaveDataList.clear()
			dir.list_dir_begin()
			var filename = dir.get_next()
			while filename != "":
				if dir.current_is_dir():
					print_debug("Directory in data folder {D}".format({"D":filename}))
				else:
					print_debug("File in data folder: {D}".format({"D":filename}))
					SaveDataList.add_item(filename)
				filename = dir.get_next()
		else:
			print_debug("Error accessing data folder: {D}".format({"D":dir}))
			DirAccess.make_dir_recursive_absolute(_saveData)
		if SaveDataList.item_count <= 0:
			$Game/Panel/VBoxContainer/GameDelete.disabled = true
			$Game/Panel/VBoxContainer/GameLoad.disabled = true

func _on_item_list_empty_clicked(_at_position, _mouse_button_index):
	SaveDataList.deselect_all()
	SelectedGame = -1

func _on_item_list_item_selected(index):
	SelectedGame = index
	_SaveGame = "{D}{G}".format( { "D":_saveData, "G":SaveDataList.get_item_text(SelectedGame) } )
	print_debug( "SaveGame: {S}".format( {"S":_SaveGame} ) )
	print_debug("Selectied List Item: {I}".format( {"I":index} ) )

func _on_game_delete_pressed():
	if SelectedGame != -1 :
		SaveDataList.remove_item(SelectedGame)
		if FileAccess.file_exists(_SaveGame):
			DirAccess.remove_absolute(_SaveGame)
		SelectedGame = -1
		SaveDataList.deselect_all()
		_on_game_visibility_changed()

func _on_game_load_pressed():
	if SelectedGame == -1 :
		_on_game_new_pressed()
		return
	print_debug( "SaveGame: {S}".format( {"S":_SaveGame} ) )
	$Game.hide()
	# from the documentation
	if FileAccess.file_exists(_SaveGame):
		### Load NEWGAME
		CTRL.Adopt(_newSaveGame)
		# find Persistant nodes and delete them
		var save_nodes = get_tree().get_nodes_in_group("Persistant")
		for node in save_nodes:
			node.queue_free()
		# open the savefile and read in the persistant objects
		var savedata = FileAccess.open(_SaveGame,FileAccess.READ)
		while savedata.get_position() < savedata.get_length():
			var node_data = savedata.get_var()
			# Firstly, we need to create the object and add it to the tree and set its position.
			var new_object = load(node_data["filename"]).instantiate()
			get_node(node_data["parent"]).add_child(new_object)
			new_object.position = node_data["position"]
			# Now we set the remaining variables.
			for i in node_data.keys():
				if i is String and (i == "filename" or i == "parent" or i == "position"):
					continue
				new_object.set(i, node_data[i])
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_game_new_pressed():
	_SaveGame = _newSaveGame
	print_debug( "GameFile: {S}".format( {"S":_SaveGame} ) )
	$Game.hide()
	CTRL.Adopt(_SaveGame)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_game_back_pressed():
	$Game.hide()
	$Main.show()

################################################################################
# from the documentation
func _on_button_save_game_pressed():
	var save_game = FileAccess.open("{D}Game.save".format({"D":_saveData}), FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persistant")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		# Call the node's save function.
		var node_data = node.call("save")
		# Store the save dictionary as a new line in the save file.
		save_game.store_var(node_data)

func _on_button_back_save_pressed():
	$Save.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.hide()
	CTRL.InGame = true

func _on_button_exit_save_pressed():
	_on_quit_ok_pressed()

################################################################################
#	Audio Panel
func _on_main_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master") ,value)

func _on_ambient_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient") ,value)

func _on_effects_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects") ,value)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music") ,value)

func _on_voice_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice") ,value)

func _on_weather_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Weather") ,value)

func _on_audio_back_button_pressed():
	$Audio.hide()
	_updateConfig()
	_saveConfig()
	$Main.show()

################################################################################
# Video Panel
func _on_chk_reflections_toggled(button_pressed):
	CFG.set_value("Environment", "ssr_enabled", button_pressed)
	ENV.ssr_enabled = button_pressed

func _on_chk_ambient_occlusion_toggled(button_pressed):
	CFG.set_value("Environment", "ssao_enabled", button_pressed)
	ENV.ssao_enabled = button_pressed

func _on_chk_indirect_lighting_toggled(button_pressed):
	CFG.set_value("Environment", "ssil_enabled", button_pressed)
	ENV.ssil_enabled = button_pressed

func _on_chk_global_illumination_toggled(button_pressed):
	CFG.set_value("Environment", "sdfgi_enabled", button_pressed)
	ENV.sdfgi_enabled = button_pressed

func _on_chk_glow_toggled(button_pressed):
	CFG.set_value("Environment", "glow_enabled", button_pressed)
	ENV.glow_enabled = button_pressed

func _on_chk_fog_toggled(button_pressed):
	CFG.set_value("Environment", "fog_enabled", button_pressed)
	ENV.fog_enabled = button_pressed

func _on_chk_color_adjust_toggled(button_pressed):
	BrightnessSlider.editable = button_pressed
	ContrastSlider.editable = button_pressed
	SaturationSlider.editable = button_pressed

func _on_brightness_slider_value_changed(value):
	CFG.set_value("Environment", "adjustment_brightness", value)
	ENV.adjustment_brightness = value

func _on_contrast_slider_value_changed(value):
	CFG.set_value("Environment", "adjustment_contrast", value)
	ENV.adjustment_contrast = value

func _on_saturation_slider_value_changed(value):
	CFG.set_value("Environment", "adjustment_saturation", value)
	ENV.adjustment_saturation = value

func _on_video_back_button_pressed():
	$Video.hide()
	_updateConfig()
	_saveConfig()
	$Main.show()

################################################################################
# Quit Panel
func _on_quit_cancel_pressed():
	$Quit.hide()
	$Main.show()

func _on_quit_ok_pressed():
	_saveConfig()
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

################################################################################
func _ready():
	CTRL = get_parent() as Controller
	_loadConfig()
	_applyConfig()
	_updateGUI()
	$Main.show()

func _input(event):
	if event.is_action_released("ui_cancel") and CTRL.InGame:
		CTRL.InGame = false
		self.show()
		# display save/pause menu
		if !$Save.is_visible_in_tree():
			$Save.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else: # return to game session
			$Save.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			self.hide()
			CTRL.InGame = true
