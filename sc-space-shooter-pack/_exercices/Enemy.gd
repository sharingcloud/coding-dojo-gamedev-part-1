extends Area2D

#######
# Enemy

signal exploded

# Max enemy speed
export (Vector2) var max_speed = Vector2(150, 75)
# Max hit points
export (int) var hit_points = 3

# Current velocity
var velocity = Vector2()
# Remaining hit points
var remaining_hit_points = 0
# Current accumulator
var accu = 0

onready var sprite = $Sprite
onready var explosion = $Explosion
onready var bullet_system = $BulletSystem
onready var animation_player = $AnimationPlayer
onready var particles = $Particles2D
onready var collision_shape = $CollisionShape2D

###################
# Lifecycle methods

func _ready():
    """When node is ready in game tree."""
    self.connect("area_entered", self, "_on_area_entered")

    self.velocity.y = self.max_speed.y
    self.remaining_hit_points = self.hit_points

func _process(delta):
    """Process each step."""
    self.accu += delta
    self.velocity.x = sin(self.accu) * self.max_speed.x
    self.bullet_system.firing = true

    self.position += self.velocity * delta

    if self.accu >= 2 * PI:
        self.accu -= 2 * PI

    self._wrap_position()

################
# Public methods

func hit():
    """Hit the enemy."""
    if self.remaining_hit_points <= 0:
        return

    self.animation_player.play("hit")
    self.remaining_hit_points -= 1
    if self.remaining_hit_points <= 0:
        self.explode()

func explode():
    """Make it explode."""
    # Reset velocity
    self.velocity = Vector2()
    self.collision_shape.set_deferred("disabled", true)

    self.emit_signal("exploded")
    self.particles.emitting = false
    self.animation_player.play("explode")
    self.explosion.play()
    yield(get_tree().create_timer(0.5), "timeout")
    self.queue_free()

func prepare_for_spawn(spawner, x, y):
    """Prepare for spawn (Spawner method)."""
    self.position.x = x
    self.position.y = y

#################
# Private methods

func _wrap_position():
    """Wrap position on screen."""
    var game_size = self.get_viewport().size
    var sprite_size = self.sprite.texture.get_size() * self.scale

    var x_lower_limit = -sprite_size.x / 2
    var x_upper_limit = game_size.x + sprite_size.x / 2
    var y_lower_limit = game_size.y + sprite_size.y / 2

    if self.position.x < x_lower_limit:
        self.position.x = x_upper_limit
    elif self.position.x > x_upper_limit:
        self.position.x = x_lower_limit

    if self.position.y > y_lower_limit:
        self.queue_free()

#################
# Event callbacks

func _on_area_entered(area):
    """When colliding with another area."""
    if area.is_in_group("Bullet") and !area.enemy_mode:
        area.queue_free()
        self.hit()
