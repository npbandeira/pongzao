extends StaticBody2D
class_name Jogador

@export var jogador1: bool
 
var velocidade_do_jogador: int = 500
var altura_player : int

func _ready():
	altura_player = $sprite.get_texture().get_size().y
	
func _process(delta):
	movimentar_jogador(delta)
	limitar_movimento_do_jogador()


# movimentação do jogador
func movimentar_jogador(delta: float) -> void:
	if jogador1:
		if Input.is_action_pressed("mv-cima-1"):
			position.y -= velocidade_do_jogador * delta
		elif Input.is_action_pressed("mv-baixo-1"):
			position.y += velocidade_do_jogador * delta
	else:
		if Input.is_action_pressed("mv-cima-2"):
			position.y -= velocidade_do_jogador * delta
		elif Input.is_action_pressed("mv-baixo-2"):
			position.y += velocidade_do_jogador * delta


func limitar_movimento_do_jogador() -> void:
	#impede que o jogador saia da tela
	position.y = clamp(position.y, 64,655) # limitar valores em um range especifico
