module entidades.RegrasUno;

import entidades.Uno;
import std.stdio;
import entidades.Carta;
import entidades.Utils;
import entidades.Baralho;
import entidades.Jogador;

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
            jogadores.mudarVezJogador();
            break;
        case "Mais2":
            carta_Mais2();
            jogadores.pularVezJogador();
            break;
        case "Joker":
            carta_Joker(carta);
            jogadores.mudarVezJogador();
            break;
        case "JokerMais4":
            carta_JokerMais4(carta);
            jogadores.pularVezJogador();
            break;
        default:
            jogadores.mudarVezJogador();
            break;
        }
    }

    protected void carta_Inverter()
    {
        jogadores.trocarSentidoRotacao();
    }

    protected void carta_Bloqueio()
    {
        writeln("Jogou a carta Bloqueio.");
        jogadores.pularVezJogador();
    }

    protected void carta_Mais2()
    {
        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 2);
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
        // Implementação do bot para escolher uma cor pro joker
    }

    public override void carta_Joker(Carta carta)
    {
        // Implementação do bot para escolher uma cor pro joker
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
