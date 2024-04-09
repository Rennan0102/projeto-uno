module entidades.RegrasUno;

import entidades.Uno;
import std.stdio;
import entidades.Carta;
import entidades.Utils;
import entidades.Baralho;

export class RegrasUno
{

    private Uno uno;
    private ListaJogadores jogadores;

    public this()
    {
        this.uno = null;
        this.jogadores = null;
    }

    public void setUno(Uno uno)
    {
        this.uno = uno;
        this.jogadores = uno.getJogadores();
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
            carta_Mais2();
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
        jogadores.trocarSentidoRotacao();
    }

    void carta_Bloqueio()
    {
        writeln("Jogou a carta Bloqueio.");
    }

    void carta_Mais2()
    {
        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 2);
    }

    void carta_Joker(Carta carta)
    {
        writeln("Jogou a carta Joker.");

        string corDaCarta = DataInput.selecionarElementoPeloUsuario(
            Baralho.CARTAS_CORES,
            4,
            "Escolha uma Cor"
        );

        carta.setCor(corDaCarta);
    }

    void carta_JokerMais4(Carta carta)
    {
        writeln("Jogou a carta Joker +4.");

        string corDaCarta = DataInput.selecionarElementoPeloUsuario(Baralho.CARTAS_CORES, 4, "Digite um numero: ");

        carta.setCor(corDaCarta);

        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 4);
    }

    // Não sei se é só isso
    public bool verficiarSeJogoEstaFinalizado()
    {
        return jogadores.getJogadorVez().getMaoCartas().length() == 0;
    }

}
