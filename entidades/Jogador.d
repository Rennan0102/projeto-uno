module entidades.Jogador;

import std.stdio;
import entidades.Carta;
import std.algorithm.iteration : map;
import entidades.Utils;

export abstract class Jogador {
    protected ArrayList!Carta maoCartas;
    protected string nome;

    this(string nome) {
        this.nome = nome;
        this.maoCartas = new ArrayList!(Carta)();
    }

    public void adicionarCarta(Carta carta) {
        maoCartas.add(carta);
    }

    public bool isUno(){
        return maoCartas.length() == 1;
    }

    // Getters & Setters

    public string getNome() {
        return nome;
    }

    public void setNome(string novoNome) {
        nome = novoNome;
    }

    public ArrayList!Carta getMaoCartas() {
        return maoCartas;
    }

    override string toString() const {
        return "Jogador ["~nome~"]";
    }

    public void mostrarMaoCartas() {
        const(Carta)[] toArray = maoCartas.toArray();    

        foreach (carta; toArray)
        {
          writefln(carta.toString());  
        }
    }

    public abstract Carta jogar();
}

export class JogadorReal : Jogador {

    public this(string nome) {
        super(nome);
    }

    override Carta jogar() {
        Carta[] cartaArray = this.maoCartas.toArray();
        int size = this.maoCartas.length();

        Carta cartaJogada = DataInput.SelecionarElemento(
            cartaArray,
            size,
           "Escolha uma Carta"  
        );  

        return cartaJogada;
    }

}


export class Bot : Jogador {

    public this(string nome) {
        super(nome);
    }

    /**
    public Carta checarNome(string nomeDesejado) {
        foreach (Carta carta; maoCartas.toArray()) {
            if (carta.getNome() == nomeDesejado) {
                maoCartas.remove(carta);
                return carta;
            }
        }

        return null; // Retorna null se não encontrar uma carta com o nome desejado
    }

    // Método para jogar uma carta especial (coringa)
    public Carta checarEspecial() {
        foreach (Carta carta; maoCartas.toArray()) {
            if (carta is CartaJoker) {
                maoCartas.remove(carta);
                return carta;
            }
        }
       
       return null; // Retorna null se não encontrar uma carta especial
    }
    */
    
    override Carta jogar() {
        // ToDo iplementar
        return null;
    }

}