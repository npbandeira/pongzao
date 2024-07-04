extends CharacterBody2D
class_name CPUIA

enum STATES {WAITING, REASONING, ACTING}

@onready var bola: Bola = %Bola

var state: STATES

var altura_janela: int
var altura_player: int

var distancia_para_reagir: int = 300

var posicao_alvo: float
var posicao_atual: float

var movimento_aleatorio: int
var movimento_aleatorio_interval: int

var incerteza_de_movimento: float = 800

const SPEED = 200

func _ready():
	movimento_aleatorio = Time.get_ticks_msec() + randi_range(1000,1500)
	state = STATES.WAITING
	altura_player = $Sprite2D.get_texture().get_size().y
	altura_janela = get_viewport_rect().size.y
	posicao_atual = altura_janela /2
	posicao_alvo = posicao_atual

func _process(delta):
	match state:
		STATES.WAITING:
			if sign(bola.velocity.x) > 0 and bola.position.x >= distancia_para_reagir:
				state = STATES.REASONING
			if Time.get_ticks_msec() >= movimento_aleatorio and bola.position.x <= distancia_para_reagir:
				posicao_alvo = bola.position.y
				movimento_aleatorio = Time.get_ticks_msec() >= movimento_aleatorio_interval
				
		STATES.REASONING:
			simular_trajetoria()
			posicao_atual = position.y
			var alvo_cima = posicao_alvo + incerteza_de_movimento
			var alvo_baixo = posicao_alvo + incerteza_de_movimento
			var posicao_alvo = randf_range(alvo_cima, alvo_baixo)
			state = STATES.ACTING
			
		STATES.ACTING:
			ir_para_posicao()
			if sign(bola.velocity.x) < 0 or bola.position.x >= get_viewport_rect().size.x:
				state = STATES.WAITING
			
	ir_para_posicao()
	
func simular_trajetoria():
	var iteracao: int = 400
	var passo: float = 1
	
	var posicao: Vector2 = bola.position
	var velocidade: Vector2 = bola.velocity
	
	while iteracao > 0:
		
		posicao += velocidade * passo
		if posicao.y >= altura_janela or posicao.y <= 0:
			velocidade.y *= -1
		if posicao.x >= 1280:
			posicao_alvo = posicao.y
			break
		iteracao -= 1
	pass
# Called when the node enters the scene tree for the first time.
func ir_para_posicao():
	posicao_atual = move_toward(posicao_atual, posicao_alvo, SPEED * get_process_delta_time())
	position.y = posicao_atual
	position.y = clamp(position.y, altura_player/ 2, altura_janela - altura_player/2)
	
