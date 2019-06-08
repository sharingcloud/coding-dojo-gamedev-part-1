extends Node2D

########
# Bullet

const BLUE_TEXTURE = preload("res://assets/textures/Lasers/laserBlue14.png")
const RED_TEXTURE = preload("res://assets/textures/Lasers/laserRed14.png")

export (Vector2) var velocity = Vector2()
export (bool) var enemy_mode = false

onready var sprite = $Sprite
onready var visibility_notifier = $VisibilityNotifier2D

###################
# Lifecycle methods

func _ready():
    self.visibility_notifier.connect("screen_exited", self, "_on_screen_exited")
    if self.enemy_mode:
        self.sprite.texture = RED_TEXTURE
    else:
        self.sprite.texture = BLUE_TEXTURE

func _process(delta):
    self.position += self.velocity * delta

#################
# Event callbacks

func _on_screen_exited():
    self.queue_free()
