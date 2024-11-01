extends RefCounted

const DEBUG = false
const DISPLAY_VELOCITY = true
const DISPLAY_FORCE = true
const USE_DOUBLE_DENSITY= true #true: double density, false: springs

const WIDTH = 1920
const HEIGHT = 1080

const GRAVITY = 1000 if USE_DOUBLE_DENSITY else 300

const INTERACTION_RADIUS = 30.0 if USE_DOUBLE_DENSITY else 10
const COLLISION_SCALE = 5 if USE_DOUBLE_DENSITY else 1.1
const SPRING_CONSTANT = 3000 / INTERACTION_RADIUS

const GRID_SIZE = 2 * INTERACTION_RADIUS
const USE_GRID = true

const PARTICLE_RADIUS = 5

# for double density
const K = 2000
const DENSITY_ZERO = 0.5
const KNEAR = 20000
