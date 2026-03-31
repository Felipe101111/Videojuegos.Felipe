extends CharacterBody2D


var speed = 600.0
var dirreccion = Vector2(0,0)
var pelota_inicio = true
var vidas = 2
var puntos = 0

@onready var tabla = get_node("../tabla")
@onready var puntaje = get_node("../puntos/Label")

func _ready():
	resetear_pelota()
	
func _physics_process(delta: float) -> void:
	
	if pelota_inicio:
		global_position = tabla.global_position + Vector2(0,-60)
		
	
	velocity = dirreccion * speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		dirreccion = dirreccion.bounce(collision.get_normal())	
		
		var collider = collision.get_collider()
		
		if collider.has_method("destruirse2"):
			collider.destruirse2()
			sumar_puntos()
			
			
	var posision = position.y>640
	if posision:
		if vidas != 0:
			resetear_pelota()
			vidas -= 1
		elif vidas == 0:
			get_tree().change_scene_to_file("res://arkanoid/perdiste_juego_2.tscn")
		


func lanzar_pelota():
	pelota_inicio = false
	dirreccion = Vector2(0, -1)
	
func _input(event):
	if event.is_action_pressed("disparar") and pelota_inicio:
		lanzar_pelota()	
	
func resetear_pelota():
	pelota_inicio = true
	velocity = Vector2(0,0)
	dirreccion = Vector2(0,0)

func sumar_puntos(): 
	puntos += 1
	puntaje.text = str(puntos)
	if puntos==24 :
		get_tree().change_scene_to_file("res://arkanoid/ganaste_juego_2.tscn")
	
