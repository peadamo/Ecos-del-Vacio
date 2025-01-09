@tool
extends MeshInstance3D
@onready var orbe: MeshInstance3D = $"."

var speed = 0.01
var time = 0
var random_heigth : float
var random_ligth : float
func _ready() -> void:
	random_heigth = randf()*4
	random_ligth = randf_range(0.8,1)


func _process(delta: float) -> void:
	var orbe_mesh = orbe.mesh
	var material : StandardMaterial3D = mesh.surface_get_material(0)
	
	
	
	material.emission_energy_multiplier=5+(random_ligth)*sin(time*5)
	
	
	
	position.y+=speed*delta*sin(time)*random_heigth

	time+=random_heigth*delta
