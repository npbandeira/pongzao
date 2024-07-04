extends Node2D

#pontuações
var pontuacao_jogador1: int = 0
var pontuacao_jogador2: int = 0
#Bola
@onready var bola: Bola = $"../Bola"

#UI
@onready var texto_pontuacao_jogador_1: Label = $"../../UI/TextoPontuacaoJogador1"
@onready var texto_pontuacao_jogador_2: Label = $"../../UI/TextoPontuacaoJogador2"
@onready var som_impacto_gol: AudioStreamPlayer = $SomImpactoGol

func _process(delta):
	receber_inputs()


#Inputs
func receber_inputs()-> void:
	if Input.is_action_just_pressed("reiniciar"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sair"):
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")


func _on_gol_1_body_entered(body: Bola):
	som_impacto_gol.play()
	pontuacao_jogador2 += 1
	texto_pontuacao_jogador_2.text = str(pontuacao_jogador2)
	bola.rodar_timer()


func _on_gol_2_body_entered(body: Bola):
	som_impacto_gol.play()
	pontuacao_jogador1 += 1
	texto_pontuacao_jogador_1.text = str(pontuacao_jogador1)
	bola.rodar_timer()
