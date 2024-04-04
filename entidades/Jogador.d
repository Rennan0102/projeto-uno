module entidades.Jogador;

import std.stdio;
import entidades.Carta;
import std.algorithm.iteration : map;
import entidades.Utils;

export class Jogador {
    private ArrayList!Carta mao;
    private string nome;

    this(string nome) {
        this.nome = nome;
        this.mao = new ArrayList!Carta();
    }

    public void adicionarCarta(Carta carta) {
        mao.add(carta);
    }

    public bool isUno(){
        return mao.size() == 1;
    }

    // Getters & Setters

    public string getNome() {
        return nome;
    }

    public void setNome(string novoNome) {
        nome = novoNome;
    }

    public Carta[] getmao() {
        return mao;
    }

     override string toString() const {
        return "Jogador ["~nome~"]";
    }

    public void mostrarMao() {
        foreach (carta; mao)
        {
          writefln(carta.toString());  
        }
    }

}
