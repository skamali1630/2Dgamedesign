extends "res://src/Actors/Actor.gd"



func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > $StompDetector.global_position.y:
		return 
	_velocity.x = 0
	die()
	
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.x *= -1 if is_on_wall() else 1
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
# *************************** HIT ANIMATION ********************************
	if _velocity.x != 0:
		$enemy.animation = "attack"
		$enemy.play()
		$enemy.flip_h = _velocity.x > 0
# *************************** MAKE ENEMY OUT FROM WORLD  *******************
	if $enemy.animation == "die":
		if $enemy.frame == 6:
			queue_free()
	

func die() -> void:
	$StompDetector/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	$enemy.animation = "die"
	$enemy.play()
	








