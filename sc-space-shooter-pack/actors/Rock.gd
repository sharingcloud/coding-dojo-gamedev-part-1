extends Area2D

######
# Rock

export (Vector2) var move_speed = Vector2(100, 100)
export (float) var rotation_speed = 0.5
export (int) var hit_points = 3

var velocity = Vector2()
var angular_velocity = 0
var remaining_hit_points = 0

onready var sprite = $Sprite
onready var explosion = $Explosion
onready var animation_player = $AnimationPlayer

###################
# Lifecycle methods

func _ready():
    self.connect("area_entered", self, "_on_area_entered")

    self.velocity = move_speed
    self.angular_velocity = rotation_speed
    self.remaining_hit_points = self.hit_points

func _process(delta):
    self.position += self.velocity * delta
    self.rotation += self.angular_velocity * delta

    self._wrap_position()

################
# Public methods

func hit():
    """Hit."""
    if self.remaining_hit_points <= 0:
        return

    self.remaining_hit_points -= 1
    if self.remaining_hit_points <= 0:
        self.explode()

func explode():
    """Explode."""
    # Reset velocity/angular velocity
    self.velocity = Vector2()
    self.angular_velocity = 0

    self.animation_player.play("explode")
    self.explosion.play()
    yield(get_tree().create_timer(0.5), "timeout")
    self.queue_free()

func prepare_for_spawn(spawner, x, y):
    """Prepare for spawn."""
    self.position.x = x
    self.position.y = y

    var m_x = rand_range(-100, 100)
    var m_y = rand_range(50, 150)
    var r = rand_range(0.5, 1)

    self.move_speed = Vector2(m_x, m_y)
    self.rotation_speed = r

#################
# Private methods

func _wrap_position():
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
    if area.is_in_group("Bullet"):
        area.queue_free()
        self.hit()
