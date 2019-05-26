extends Control

############
# GameScreen

onready var player = $Player
onready var bullets = $Bullets

###################
# Lifecycle methods

func _ready():
    self.player.bullet_system.connect("fire", self, "_on_fire")

#################
# Event callbacks

func _on_fire(scene, pos, vel):
    var instance = scene.instance()
    instance.position = pos
    instance.velocity = vel

    self.bullets.add_child(instance)
