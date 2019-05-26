extends Node2D

##############
# BulletSystem

signal fire(scene, pos, vel)

export (PackedScene) var bullet = null
export (Vector2) var initial_velocity = Vector2(0, -500)
export (float) var fire_delay = 0.1
export (bool) var firing = false
export (bool) var can_fire = true

onready var timer = $Timer

###################
# Lifecycle methods

func _ready():
    self.timer.connect("timeout", self, "_on_timeout")
    self.timer.wait_time = self.fire_delay

func _process(delta):
    if self.firing:
        self.fire()

#################
# Private methods

################
# Public methods

func fire():
    if self.can_fire:
        var pos = self.global_position
        var vel = self.initial_velocity

        self.emit_signal("fire", self.bullet, pos, vel)
        self.timer.start()
        self.firing = false
        self.can_fire = false

#################
# Event callbackss

func _on_timeout():
    self.can_fire = true
