module entidades.Jogador;

import entidades.Carta;

export class Jogador {
    private Carta[] cartas;
    private string nome;
    private bool vez;

    this(string nome, Carta[] cartas, bool vez) {
        this.nome = nome;
        this.cartas = cartas;
        this.vez = vez;
    }

    public string getNome() {
        return nome;
    }

    public Carta[] getCartas() {
        return cartas;
    }

    public bool getVez() {
        return vez;
    }

    public void setNome(string novoNome) {
        nome = novoNome;
    }

    public void setCartas(Carta[] novasCartas) {
        cartas = novasCartas;
    }

    public void setVez(bool novaVez) {
        vez = novaVez;
    }
}
