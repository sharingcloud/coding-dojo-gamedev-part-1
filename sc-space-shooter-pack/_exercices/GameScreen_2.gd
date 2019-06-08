extends Control

############
# GameScreen

onready var player = $Player
onready var bullets = $Bullets
onready var rock_spawner = $RockSpawner
onready var enemy_spawner = $EnemySpawner
onready var hud_score = $CanvasLayer/HUD/MarginContainer/HBoxContainer/ScoreContainer/Value
onready var hud_best = $CanvasLayer/HUD/MarginContainer/HBoxContainer/BestContainer/Value

var score = 0
var best_score = 0

###################
# Lifecycle methods

func _ready():
    self.player.connect("dead", self, "_on_player_dead")
    self.player.bullet_system.connect("fire", self, "_on_fire")
    self.rock_spawner.connect("spawn", self, "_on_rock_spawn")
    self.enemy_spawner.connect("spawn", self, "_on_enemy_spawn")

#################
# Private methods

func _add_score(value):
    self.score += value
    if self.score > self.best_score:
        self.best_score = self.score
    self._update_hud()

func _update_hud():
    self.hud_score.text = str(self.score)
    self.hud_best.text = str(self.best_score)

#################
# Event callbacks

func _on_rock_spawn(spawner, element):
    element.connect("exploded", self, "_on_rock_exploded")

func _on_enemy_spawn(spawner, element):
    element.connect("exploded", self, "_on_enemy_exploded")
    element.bullet_system.connect("fire", self, "_on_fire")

func _on_fire(scene, enemy_mode, pos, vel):
    var instance = scene.instance()
    instance.position = pos
    instance.velocity = vel
    instance.enemy_mode = enemy_mode

    self.bullets.add_child(instance)

func _on_player_dead():
    self.score = 0
    self._update_hud()

func _on_rock_exploded():
    self._add_score(100)

func _on_enemy_exploded():
    self._add_score(500)
