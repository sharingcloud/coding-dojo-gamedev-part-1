extends Node2D

onready var particles = $Particles2D

################
# Public methods

func play():
    """Play."""
    self.particles.emitting = true
