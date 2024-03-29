extends Control

############
# GameScreen

onready var player = $Player
onready var bullets = $Bullets
onready var rock_spawner = $RockSpawner

var score = 0
var best_score = 0

###################
# Lifecycle methods

func _ready():
    self.player.connect("dead", self, "_on_player_dead")
    self.player.bullet_system.connect("fire", self, "_on_fire")
    self.rock_spawner.connect("spawn", self, "_on_rock_spawn")

#################
# Private methods

func _add_score(value):
    self.score += value
    if self.score > self.best_score:
        self.best_score = self.score

#################
# Event callbacks

func _on_rock_spawn(spawner, element):
    element.connect("exploded", self, "_on_rock_exploded")

func _on_fire(scene, enemy_mode, pos, vel):
    var instance = scene.instance()
    instance.position = pos
    instance.velocity = vel
    instance.enemy_mode = enemy_mode

    self.bullets.add_child(instance)

func _on_player_dead():
    self.score = 0

func _on_rock_exploded():
    self._add_score(100)
