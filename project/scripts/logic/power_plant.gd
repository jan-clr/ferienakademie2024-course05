extends Node2D

class_name PowerPlant

var particle_simulation
var done : bool = false

var flow_count : int
var flow_counts = []
@export var timeframes_to_monitor = 5
@export var flow_threshold = 15

signal enough_water_flow

func set_particle_simulation(_particle_simulation : ParticleSimulation):
	particle_simulation = _particle_simulation.SIM

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if particle_simulation == null or done:
		return
	var particles = particle_simulation.get_particle_positions()
	var to_remove = Array()

	var i = 0
	for p in particles:
		if $TextureRect.get_global_rect().has_point(p):
			flow_count += 1
			to_remove.append(i)
		i += 1
	for j in to_remove.size():
		particle_simulation.delete_particle(to_remove[j])


func is_flow_sufficient() -> bool:
	for count in flow_counts:
		if count < flow_threshold:
			return false
	return true


func _on_flow_timer_timeout() -> void:
	flow_counts.append(flow_count)
	flow_count = 0  

	if flow_counts.size() > timeframes_to_monitor:
		flow_counts.pop_front()

	if flow_counts.size() == timeframes_to_monitor:
		if is_flow_sufficient():
			done = true
			print(str(self) + " done")
			emit_signal("enough_water_flow")
		else:
			done = false
			print(str(self) + " not done")
