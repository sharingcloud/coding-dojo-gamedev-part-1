extends Area2D

########
# Player

signal dead

const DAMP_FACTOR = 0.9
const MOVE_SPEED = Vector2(500, 500)

var velocity = Vector2()
var is_dead = false

var initial_position = Vector2()

onready var collision_shape = $CollisionShape2D
onready var animation_player = $AnimationPlayer
onready var explosion = $Explosion
onready var bullet_system = $BulletSystem
onready var death_timer = $DeathTimer

###################
# Lifecycle methods

func _ready():
    # Connect the "area_entered" signal from Area2D to "_on_area_entered" method.
    self.connect("area_entered", self, "_on_area_entered")
    self.death_timer.connect("timeout", self, "_on_death_timeout")

    self.initial_position = self.position

func _process(delta):
    # Do not process if dead
    if self.is_dead:
        return

    # Get movement
    var movement = self._handle_movement()
    if movement == Vector2():
        # Damp velocity if idle
        self.velocity *= DAMP_FACTOR
    else:
        # Update velocity
        self.velocity = movement * MOVE_SPEED

    # Fire
    self._handle_fire()

    # Update position
    self.position += self.velocity * delta
    # Make sure you are still on screen
    self._clamp_position()

################
# Public methods

func explode():
    """Explode."""
    # Do not explode if dead
    if self.is_dead:
        return

    # Reset velocity
    self.velocity = Vector2()
    self.bullet_system.firing = false
    self.is_dead = true

    self.explosion.play()
    self.animation_player.play("explode")
    self.collision_shape.set_deferred("disabled", true)
    self.emit_signal("dead")

    self.death_timer.start()

#################
# Private methods

func _handle_movement():
    """Compute movement."""
    var movement = Vector2()
    if Input.is_action_pressed("ui_left"):
        movement.x -= 1
    if Input.is_action_pressed("ui_right"):
        movement.x += 1
    if Input.is_action_pressed("ui_up"):
        movement.y -= 1
    if Input.is_action_pressed("ui_down"):
        movement.y += 1

    return movement

func _handle_fire():
    """Handle fire."""
    if Input.is_action_pressed("ui_accept"):
        self.bullet_system.firing = true
    else:
        self.bullet_system.firing = false

func _clamp_position():
    """Clamp position."""
    var game_size = self.get_viewport().size

    self.position.x = clamp(self.position.x, 0, game_size.x)
    self.position.y = clamp(self.position.y, 0, game_size.y)

#################
# Event callbacks

func _on_area_entered(area):
    if area.is_in_group("Rock"):
        area.explode()
        self.explode()
    elif area.is_in_group("Enemy"):
        self.explode()
    elif area.is_in_group("Bullet") and area.enemy_mode:
        area.queue_free()
        self.explode()

func _on_death_timeout():
    self.position = self.initial_position
    self.is_dead = false
    self.collision_shape.set_deferred("disabled", false)

    self.animation_player.play("idle")
