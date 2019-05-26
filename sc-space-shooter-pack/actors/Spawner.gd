extends Node2D

#########
# Spawner

export (PackedScene) var scene = null
export (float) var spawn_delay = 2

onready var timer = $Timer
onready var container = $Container

###################
# Lifecycle methods

func _ready():
    self.timer.connect("timeout", self, "_on_timeout")

    self.timer.wait_time = self.spawn_delay
    self.timer.start()

#################
# Private methods

func _spawn(x, y):
    var instance = self.scene.instance()
    instance.prepare_for_spawn(self, x, y)

    self.container.add_child(instance)

#################
# Event callbacks

func _on_timeout():
    var game_size = self.get_viewport().size

    var x = rand_range(game_size.x / 4, game_size.x - game_size.x / 4)
    var y = -100
    self._spawn(x, y)
