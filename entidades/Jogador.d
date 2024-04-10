module entidades.Jogador;

import std.stdio;
import entidades.Carta;
import std.algorithm.iteration : map;
import entidades.Utils;
import entidades.Baralho;
import entidades.Uno;
import std.string;

export abstract class Jogador
{
    protected ArrayList!Carta maoCartas;
    protected string nome;

    this(string nome)
    {
        this.nome = nome;
        this.maoCartas = new ArrayList!(Carta)();
    }

    public void adicionarCarta(Carta carta)
    {
        maoCartas.add(carta);
    }

    public bool isUno()
    {
        return maoCartas.length() == 1;
    }

    // Getters & Setters

    public string getNome()
    {
        return nome;
    }

    public void setNome(string novoNome)
    {
        nome = novoNome;
    }

    public ArrayList!Carta getMaoCartas()
    {
        return maoCartas;
    }

    public void removerCarta(Carta carta)
    {
        return maoCartas.remove(carta);
    }

    override string toString() const
    {
        return "Jogador [" ~ nome ~ "]";
    }

    public void mostrarMaoCartas()
    {
        const(Carta)[] toArray = maoCartas.toArray();

        foreach (i, carta; toArray)
        {
            writeln(++i, ". ", carta.toString());
        }
    }

    public abstract Carta jogar(Uno uno);
}

export class JogadorReal : Jogador
{

    public this(string nome)
    {
        super(nome);
    }

    override Carta jogar(Uno uno)
    {
        Carta[] cartaArray = this.maoCartas.toArray();
        int size = this.maoCartas.length();

        Carta cartaJogada = null;

        while (true)
        {

            cartaJogada = DataInput.selecionarElementoPeloUsuario(
                cartaArray,
                size,
                "Escolha uma Carta"
            );

            try
            {
                uno.testarCartaValida(cartaJogada);
                return cartaJogada;
            }
            catch (JogadaInvalidaException error)
            {
                writeln();
                writefln("Error: " ~ error.msg);
                writeln();
                continue;
            }
        }
    }

}

export class Bot : Jogador
{
    public this(string nome)
    {
        super(nome);
    }

    override Carta jogar(Uno uno)
    {

        Carta[] cartaArray = this.maoCartas.toArray();

        writefln("Escolhendo uma carta (%s) ...", nome);
        Decoracao.aMimir(2);

        foreach (cartaMao; cartaArray)
        {

            if (cartaMao.getNome() == "Joker" || cartaMao.getNome() == "JokerMais4")
            {
                return cartaMao;
            }

            try
            {
                uno.testarCartaValida(cartaMao);
                return cartaMao;
            }
            catch (JogadaInvalidaException err)
            {
            }

        }

        throw new Exception("Nao eh pra chegar aqui");
    }

    public override string toString() const {
        return super.toString() ~ " (Bot)";
    }

}
