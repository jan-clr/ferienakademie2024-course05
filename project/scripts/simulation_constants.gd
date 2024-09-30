extends RefCounted

const DEBUG = false
const DISPLAY_VELOCITY = false
const DISPLAY_FORCE = true

const WIDTH = 1920
const HEIGHT = 1080

# set to -1 to use the water_source
const NUMBER_PARTICLES = 500

const GRAVITY = 300

const INTERACTION_RADIUS = 10.0
const SPRING_CONSTANT = 3000 / INTERACTION_RADIUS

const GRID_SIZE = 2 * INTERACTION_RADIUS
const USE_GRID = true
