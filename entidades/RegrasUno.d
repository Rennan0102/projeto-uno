module entidades.RegrasUno;

import entidades.Uno;
import std.stdio;
import entidades.Carta;
import entidades.Utils;
import entidades.Baralho;
import entidades.Jogador;

import std.algorithm;
import std.array;
import std.range;
import std.typecons;
import std.conv;

abstract class ExecutorCarta
{

    private Uno uno;
    private ListaJogadores jogadores;

    this(Uno uno)
    {
        this.uno = uno;
        this.jogadores = uno.getJogadores();
    }

    public void jogarCarta(Carta carta)
    {
        string nomeCarta = carta.getNome();

        uno.testarCartaValida(carta);

        switch (nomeCarta)
        {
        case "Bloqueio":
            carta_Bloqueio();
            break;
        case "Inverter":
            carta_Inverter();
            break;
        case "Mais2":
            carta_Mais2();
            break;
        case "Joker":
            carta_Joker(carta);
            jogadores.mudarVezJogador();
            break;
        case "JokerMais4":
            carta_JokerMais4(carta);
            break;
        default:
            jogadores.mudarVezJogador();
            break;
        }
    }

    protected void carta_Inverter()
    {
        jogadores.trocarSentidoRotacao();
        jogadores.mudarVezJogador();
    }

    protected void carta_Bloqueio()
    {
        writeln("Jogou a carta Bloqueio.");
        writefln(jogadores.getJogadorVezProximo().getNome() ~ " foi bloqueado. Perdeu a vez!");
        jogadores.pularVezJogador();
    }

    protected void carta_Mais2()
    {
        writefln(jogadores.getJogadorVezProximo().getNome() ~ " comprou duas cartas. Perdeu a vez!");

        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 2);
        jogadores.pularVezJogador();
    }

    protected abstract void carta_JokerMais4(Carta carta);
    protected abstract void carta_Joker(Carta carta);
}

class ExecutorCartaBot : ExecutorCarta
{

    this(Uno uno)
    {
        super(uno);
    }

    public override void carta_JokerMais4(Carta carta)
    {
        Jogador jogador = uno.getJogadorVez();
        Carta[] cartas = jogador.getMaoCartas().toArray();

        auto contagemCores = ["Azul": 0, "Verde": 0, "Vermelho": 0, "Amarelo": 0];

        foreach (cartaBaralho; cartas)
        {
            contagemCores[cartaBaralho.getCor()]++;
        }

        string corMaiorQuantidade = "Azul";
        int quantidadeMaior = 0;

        foreach (cor, quantidade; contagemCores)
        {
            if (quantidade > quantidadeMaior)
            {
                corMaiorQuantidade = cor;
                quantidadeMaior = quantidade;
            }
        }

        carta.setCor(corMaiorQuantidade);
        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 4);
        writefln(jogadores.getJogadorVezProximo().getNome() ~ " comprou quatro cartas. Perdeu a vez!");
        jogadores.pularVezJogador();
    }

    public override void carta_Joker(Carta carta)
    {
        Jogador jogador = uno.getJogadorVez();
        Carta[] cartas = jogador.getMaoCartas().toArray();

        auto contagemCores = ["Azul": 0, "Verde": 0, "Vermelho": 0, "Amarelo": 0];

        foreach (cartaBaralho; cartas)
        {
            contagemCores[cartaBaralho.getCor()]++;
        }

        string corMaiorQuantidade = "Verde";
        int quantidadeMaior = 0;

        foreach (cor, quantidade; contagemCores)
        {
            if (quantidade > quantidadeMaior)
            {
                corMaiorQuantidade = cor;
                quantidadeMaior = quantidade;
            }
        }

        carta.setCor(corMaiorQuantidade);
    }
}

class ExecutorCartaJogador : ExecutorCarta
{

    this(Uno uno)
    {
        super(uno);
    }

    public override void carta_JokerMais4(Carta carta)
    {
        writeln("Jogou a carta Joker +4.");

        string corDaCarta = DataInput.selecionarElementoPeloUsuario(
            Baralho.CARTAS_CORES,
            4,
            "Digite um numero: "
        );

        carta.setCor(corDaCarta);

        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 4);

        writefln(jogadores.getJogadorVezProximo().getNome() ~ " comprou quatro cartas. Perdeu a vez!");
        jogadores.pularVezJogador();
    }

    public override void carta_Joker(Carta carta)
    {
        writeln("Jogou a carta Joker.");

        string corDaCarta = DataInput.selecionarElementoPeloUsuario(
            Baralho.CARTAS_CORES,
            4,
            "Escolha uma Cor"
        );

        carta.setCor(corDaCarta);
    }

}

export class RegrasUno
{
    private Uno uno;
    private ListaJogadores jogadores;
    private ExecutorCartaJogador executorCartaJogador;
    private ExecutorCartaBot executorCartaBot;

    public this()
    {
        this.uno = null;
        this.jogadores = null;
        this.executorCartaBot = null;
        this.executorCartaJogador = null;
    }

    public void setUno(Uno uno)
    {
        this.uno = uno;
        this.jogadores = uno.getJogadores();
        this.executorCartaBot = new ExecutorCartaBot(uno);
        this.executorCartaJogador = new ExecutorCartaJogador(uno);
    }

    public void jogarCarta(Carta carta)
    {
        Jogador jogadorVez = jogadores.getJogadorVez();

        if (cast(Bot) jogadorVez)
        {
            executorCartaBot.jogarCarta(carta);
        }
        else
        {
            executorCartaJogador.jogarCarta(carta);
        }

    }

    // Não sei se é só isso
    public bool verficiarSeJogoEstaFinalizado(Jogador jogadorVezAnterior)
    {
        return jogadorVezAnterior.getMaoCartas().length() == 0;
    }

}
