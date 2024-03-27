module entidades.Jogador;

import entidades.Carta;

export class Jogador {
    private Carta[] maoJogador;
    private string nome;
    private bool vez;

    this(string nome, bool vez) {
        this.nome = nome;
        this.vez = vez;
        this.maoJogador = [];
    }

    public string getNome() {
        return nome;
    }

    public Carta[] getMaoJogador() {
        return maoJogador;
    }

    public bool getVez() {
        return vez;
    }

    public void setNome(string novoNome) {
        nome = novoNome;
    }

    public void setVez(bool novaVez) {
        vez = novaVez;
    }

    public void adicionarCarta(Carta carta) {
        maoJogador ~= carta;
    }  
}
