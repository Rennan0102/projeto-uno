module entidades.RegrasUno;

import entidades.Uno;
import std.stdio;
import entidades.Carta;
import entidades.Utils;
import entidades.Baralho;

export class RegrasUno
{

    private Uno uno;

    public this()
    {
        this.uno = null;
    }

    public void setUno(Uno uno)
    {
        this.uno = uno;
    }

    public void testarCartaValida(Carta carta)
    {
        Carta cartaTopoPilha = uno.getCartasUsadas().getLast();

        string nomeCartaTopoPilha = cartaTopoPilha.getNome();
        string corCartaTopoPilha = cartaTopoPilha.getCor();

        string nomeCarta = carta.getNome();
        string corCarta = carta.getCor();

        if ((nomeCartaTopoPilha == "Joker" || corCartaTopoPilha == "JokerMais4") && corCarta != corCartaTopoPilha)
        {
            throw new JogadaInvalidaException("A cor tem que ser igual a selecionada pelo o player");
        }

        if (
            nomeCarta != "Joker" &&
            nomeCarta != "JokerMais4" &&
            nomeCarta != nomeCartaTopoPilha &&
            corCarta != corCartaTopoPilha
            )
        {
            throw new JogadaInvalidaException("Jogada Inválida");
        }
    }

    void jogarCarta(Carta carta)
    {
        string nomeCarta = carta.getNome();

        this.testarCartaValida(carta);

        switch (nomeCarta)
        {
        case "Bloqueio":
            carta_Bloqueio();
            break;
        case "Inverter":
            carta_Inverter();
            break;
        case "Mais2":
            carta_Mais2(carta);
            break;
        case "Joker":
            carta_Joker(carta);
            break;
        case "JokerMais4":
            carta_JokerMais4(carta);
            break;
        default:
            break;
        }
    }

    public void carta_Inverter()
    {
        this.uno.inverterSentido();
    }

    void carta_Bloqueio()
    {
        writeln("Jogou a carta Bloqueio.");
        uno.pularVezJogador();
    }

    void carta_Mais2(Carta carta)
    {
        ListaJogadores jogadores = uno.getJogadores();

        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 2);
        uno.pularVezJogador();
    }

    void carta_Joker(Carta carta)
    {
        writeln("Jogou a carta Joker.");

        string corDaCarta = DataInput.SelecionarElemento(
            Baralho.CARTAS_CORES,
            4,
            "Escolha uma Cor"
        );

        carta.setCor(corDaCarta);
    }

    void carta_JokerMais4(Carta carta)
    {
        writeln("Jogou a carta Joker +4.");

        ListaJogadores jogadores = uno.getJogadores();

        string corDaCarta = DataInput.SelecionarElemento(Baralho.CARTAS_CORES, 4, "Digite um numero: ");

        carta.setCor(corDaCarta);

        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 4);
        uno.pularVezJogador();
    }

    // Não sei se é só isso
    public bool verficiarSeJogoEstaFinalizado()
    {
        return uno.getJogadorVez().getMaoCartas().length() == 0;
    }

}
