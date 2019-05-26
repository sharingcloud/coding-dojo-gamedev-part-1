extends Node2D

########
# Bullet

export (Vector2) var velocity = Vector2()

onready var visibility_notifier = $VisibilityNotifier2D

###################
# Lifecycle methods

func _ready():
    self.visibility_notifier.connect("screen_exited", self, "_on_screen_exited")

func _process(delta):
    self.position += self.velocity * delta

#################
# Event callbacks

func _on_screen_exited():
    self.queue_free()
