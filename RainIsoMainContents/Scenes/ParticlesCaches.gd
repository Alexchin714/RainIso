extends CanvasLayer

var projectilesParticles = preload("res://RainIsoMainContents/Shader/Particles.tres")
var projectilesTownParticles = preload("res://RainIsoMainContents/Shader/ParticlesTown.tres")

var material = [
	projectilesParticles,
	projectilesTownParticles,
]

var frames = 0
var loaded = false

func _ready():
	for materials in material:
		var particles = Particles2D.new()
		particles.set_process_material(materials)
		particles.poset_one_shot(true)
		particles.set_modulate(Color(1,1,1,0))
		particles.set_emitting(true)
		self.add_child(particles)

func _physics_process(delta):
	if frames >= 3:
		set_physics_process(false)
		loaded = true
	frames += 1
