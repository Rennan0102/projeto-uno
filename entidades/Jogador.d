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

    protected void checarUno(){ // Verifica se o Jogador possui apenas uma Carta na mão
        if (maoJogador.length == 1){
            uno = true;
        }
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

    public bool getIsUno(){
        return uno;
    }
}
