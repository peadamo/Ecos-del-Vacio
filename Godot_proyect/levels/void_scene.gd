@tool
extends Node3D
@onready var dream_sphere: MeshInstance3D = $Dream_sphere
@onready var player: CharacterBody3D = $Player
@onready var background_music: AudioStreamPlayer = $Background_Music
@onready var dream_esphere_sound: AudioStreamPlayer = $Dream_esphere_sound

@export var orbes_dist : float = 10
var last_value_orbes_dist

@export var orbes_number : int = 10
var last_value_orbes_number

@export var lines_angle : float = 10.0
var last_value_lines_angle

@export var random_orbes_density : int = 100
var last_value_random_orbes_density

func _ready() -> void:
	last_value_orbes_dist = orbes_dist
	last_value_orbes_number = orbes_number
	last_value_lines_angle = lines_angle
	update()



func _process(delta: float) -> void:
	
	dream_sphere.rotate_y(0.001)
	dream_sphere.rotate_x(0.001)
	dream_sphere.rotate_z(0.001)
	
	
	
	if orbes_dist != last_value_orbes_dist:
		last_value_orbes_dist=orbes_dist
		update()
	elif orbes_number != last_value_orbes_number:
		last_value_orbes_number = orbes_number
		update()
	elif lines_angle != last_value_lines_angle:
		last_value_lines_angle = lines_angle
		update()
	elif random_orbes_density != last_value_random_orbes_density:
		last_value_random_orbes_density = random_orbes_density
		update()
		
	var max_distance = 10100
	var dream_esphere_sound_max_sound = 24.0
	var distance_to_player = dream_sphere.position.distance_squared_to(player.position)
	dream_esphere_sound.volume_db = dream_esphere_sound_max_sound*(max_distance-distance_to_player)/max_distance
	background_music.volume_db = -20+10*(distance_to_player)/max_distance
		
		
		
		
@onready var orbes_container: Node3D = $"Orbes Container"
@onready var line_01: Node3D = $"Orbes Container/Line_01"
@onready var line_02: Node3D = $"Orbes Container/Line_02"
@onready var random: Node3D = $"Orbes Container/Random"

		
func update():
	var ORBES : PackedScene= load("res://levels/Orbes.tscn")
	
	line_01.rotation.y = deg_to_rad(lines_angle)
	line_02.rotation.y = -deg_to_rad(lines_angle)
	
	
		
		
	for child in line_01.get_children():
		child.queue_free()
	for child in line_02.get_children():
		child.queue_free()
	for child in random.get_children():
		child.queue_free()
	
	for i in orbes_number:
		line_01.add_child(ORBES.instantiate())
		var last_orbe_01 = line_01.get_child(-1)
		last_orbe_01.owner = get_tree().edited_scene_root
		last_orbe_01.position.x = (i+2)*orbes_dist
		last_orbe_01.position.y = randf_range(-1,1)
		
		line_02.add_child(ORBES.instantiate())
		var last_orbe_02 = line_02.get_child(-1)
		last_orbe_02.owner = get_tree().edited_scene_root
		last_orbe_02.position.x = (i+2)*orbes_dist
		last_orbe_02.position.y = randf_range(-1,1)

	for i in random_orbes_density:
		var random_angle = deg_to_rad(randf_range(0,360))
		
		if random_angle > deg_to_rad(lines_angle*2) and random_angle < deg_to_rad(360-lines_angle*2):
		
			random.add_child(ORBES.instantiate())
			var last_orbe_ran = random.get_child(-1)
			last_orbe_ran.owner = get_tree().edited_scene_root
			var random_distance = (randf()*orbes_dist*orbes_number-orbes_dist)+orbes_dist*2

			last_orbe_ran.position.x = sin(random_angle)*random_distance
			last_orbe_ran.position.z = cos(random_angle)*random_distance
			
			#last_orbe_ran.position.x = cos(random_angle)*random_distance
			#last_orbe_ran.position.z = sin(random_angle)*random_distance
		
