extends Node2D

var _width = 400
var _height = 100

var grid : Array = []
var gridNoise = FastNoiseLite.new()


# Basic functions

var kernel_radius = 5
func cubic_spline_kernel(x_origin: Vector2, x: Vector2) -> float:
	var distance = x_origin.distance_to(x)
	var q = distance / kernel_radius
	
	if q > 1.0:
		return 0.0
	
	var sigma = 10.0 / (7.0 * PI * kernel_radius * kernel_radius)
	var kernel_value: float
	
	if q <= 0.5:
		kernel_value = 6.0 * (q * q * q - q * q) + 1.0
	else:
		kernel_value = 2.0 * pow(1.0 - q, 3)
	
	return sigma * kernel_value

func on_grid(grid_pos):
	return 0 <= grid_pos.x and grid_pos.x < len(grid[0]) and 0 <= grid_pos.y and grid_pos.y < len(grid)


# Editor functions

func apply_kernel(grid_pos, target_value):
	var kernel_multiplier = 100
	
	for i in range(-kernel_radius - 1, kernel_radius + 1):
		for j in range(-kernel_radius - 1, kernel_radius + 1):
			var grid_pos_kernel = Vector2(grid_pos.x + j, grid_pos.y + i)
			
			if on_grid(grid_pos_kernel):
				var kernel_value = kernel_multiplier * cubic_spline_kernel(grid_pos, grid_pos_kernel)
				
				kernel_value = min(1.0, max(0, kernel_value))
				
				var new_grid_value = (1 - kernel_value) * grid[grid_pos_kernel.y][grid_pos_kernel.x] + kernel_value * target_value
				
				grid[grid_pos_kernel.y][grid_pos_kernel.x] = min(1.0, max(0, new_grid_value))


func generateGrid():
	var returnBoundaries : Array[PackedVector2Array] = [] # all boundaries
	var boundary : PackedVector2Array = [] # current boundary

	# Generate grid array
	for y in range(_height):
		var grid_row = []
		for x in range(_width):
			grid_row.append(0)
		grid.append(grid_row)

	# Initialize noise generator
	gridNoise.seed = 0815;
	gridNoise.noise_type = FastNoiseLite.TYPE_PERLIN
	gridNoise.fractal_octaves = 4
	gridNoise.frequency = 0.0075

	# Fill grid with noise data and generate output boundaries
	for x in range(_width):
		var maxHeight = round(gridNoise.get_noise_1d(x) * _height * 2 + _height / 2.5)

		boundary.append(Vector2(x, maxHeight))

		for y in range(_height):
			if maxHeight <= y:
				grid[y][x] = 1

	# Genereate the two bottom points
	boundary.append(Vector2(_width - 1, _height - 1))
	boundary.append(Vector2(0, 		    _height - 1))

	returnBoundaries.append(boundary)

	return returnBoundaries


# Godot functions 

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
