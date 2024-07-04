extends CharacterBody2D

class_name Bola

@onready var timer: Timer = $Timer
@onready var som_impacto_barreira: AudioStreamPlayer = $SomImpactoBarreira
@onready var som_impacto_jogador: AudioStreamPlayer = $SomImpactoJogador

const VELOCIDADE_INICIAL: int = 500
const ACCELERACAO: int = 50

var velocidade_maxima_da_bola: int = 1280
var velocidade_minima_da_bola: int = 500
var direcao_inicial: Vector2
var direcao: Vector2
var velocidade: int

var x_minimo: float = 0
var x_maximo: float = 1280
var y_minimo: float = 0.0
var y_maximo: float = 720

var win_size: Vector2

func _ready():
	win_size = get_viewport_rect().size
	rodar_timer()

#region reseta a posição da bola

func resetar_bola() -> void:
	position.x = win_size.x / 2
	position.y = win_size.y / 2 
	velocidade = VELOCIDADE_INICIAL
	escolher_direcao_inicial()
	
#endregion
func _physics_process(delta):
	velocity = velocidade * direcao  * delta
	var collision = move_and_collide(velocity)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider is Jogador or collider is CPUIA:
			velocidade += ACCELERACAO
			direcao = f_nova_direcao(collider) 
			som_impacto_jogador.play()
		else:
			direcao = direcao.bounce(collision.get_normal()) 
			som_impacto_barreira.play()
	
#temporizador
func rodar_timer() -> void:
	timer.start()
	
# gera um direção para bola
func escolher_direcao_inicial() -> void:
	var angle: int = randi_range(15,45)
	var x_aleatorio = [-1, 1].pick_random()
	var y_aleatorio = [-1, 1].pick_random()
	# calcula o angulo da direção
	direcao_inicial = Vector2(cos(deg_to_rad(angle)),sin(deg_to_rad(angle)))
	
	direcao_inicial.x *= x_aleatorio
	direcao_inicial.y *= y_aleatorio
	
	direcao = direcao_inicial
	
func f_nova_direcao(collider) -> Vector2:
	var bola_y = position.y
	var raquete_y = collider.position.y
	var distancia  = bola_y - raquete_y
	var nova_direcao:= Vector2()
	
	if direcao.x > 0:
		nova_direcao.x = -1
	else:
		nova_direcao.x = 1
		
	nova_direcao.y = (distancia /(collider.altura_player/ 2)) * 0.6
	return nova_direcao.normalized()
	
func _on_timer_timeout():
	resetar_bola()
