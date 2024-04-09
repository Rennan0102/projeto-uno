module entidades.Jogador;

import std.stdio;
import entidades.Carta;
import std.algorithm.iteration : map;
import entidades.Utils;
import entidades.Baralho;


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

    public void removerCarta(Carta carta) {
        return maoCartas.remove(carta);
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

    

    public abstract Carta jogar(Carta carta, Baralho baralho);
}

export class JogadorReal : Jogador {

    public this(string nome) {
        super(nome);
    }

    override Carta jogar(Carta carta, Baralho baralho) {
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

    
    override Carta jogar(Carta cartaTopoDescarte, Baralho baralho) {

        Carta[] cartaArray = this.maoCartas.toArray();
        int size = this.maoCartas.length();
        
        writefln("Escolhendo uma carta ...");

       foreach (Carta cartaMao; cartaArray)
       {
        if(cartaMao.getCor() == cartaTopoDescarte.getCor() || cartaMao.getNome() == cartaTopoDescarte.getNome())
        { 
            return cartaMao;
        }

         if(cartaMao.getNome() == "Joker" ||  cartaMao.getNome() == "JokerMais4")
        { 
            cartaMao.setCor(cartaTopoDescarte.getCor());
            return cartaMao;
        }
       }
       
       // pega carta baralho
       Carta cartaBaralho = baralho.getCarta();
       if(cartaBaralho.getCor() == cartaTopoDescarte.getCor() || cartaBaralho.getNome() == cartaTopoDescarte.getNome())
        { 
            return cartaBaralho;
        }

         if(cartaBaralho.getNome() == "Joker" ||  cartaBaralho.getNome() == "JokerMais4")
        { 
            cartaBaralho.setCor(cartaTopoDescarte.getCor());
            return cartaBaralho;
        }

       Carta cartaNull = new Carta();
       

       return cartaNull ;
    }

}