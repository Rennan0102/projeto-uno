module entidades.Jogador;

import entidades.Carta;

export class Jogador {
    private Carta[] maoJogador;
    private string nome;
    private bool uno;

    this(string nome) {
        this.nome = nome;
        this.uno = false;
    }

    public void adicionarCarta(Carta carta) {
        maoJogador ~= carta;
    }

    public bool getIsUno(){
        return maoJogador.length == 1;
    }

    // Getters & Setters

    public string getNome() {
        return nome;
    }

    public void setNome(string novoNome) {
        nome = novoNome;
    }

    public Carta[] getMaoJogador() {
        return maoJogador;
    }

     override string toString() const {
        return "Jogador ["~nome~"]";
    }

}
