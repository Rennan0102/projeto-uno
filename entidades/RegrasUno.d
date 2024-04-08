module entidades.RegrasUno;

import entidades.Uno;
import std.stdio;
import entidades.Carta;
import entidades.Utils;


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

    void jogarCarta(Carta carta, ListaJogadores jogadores)
    {
        string nomeCarta = carta.getNome();

        writeln(nomeCarta);

        switch (nomeCarta)
        {
        case "Zero":
            carta_Zero();
            break;
        case "Um":
            carta_Um();
            break;
        case "Bloqueio":
            carta_Bloqueio(jogadores);
            break;
        case "Inverter":
            carta_Inverter();
            break;
        case "Mais2":
            carta_Mais2(jogadores);
            break;
        case "Joker":
            carta_Joker(carta);
            break;
        case "JokerMais4":
            carta_JokerMais4(carta, jogadores);
            break;
        default:
            carta_Comum();
        }
    }

    public void carta_Inverter()
    {
        this.uno.inverterSentido();
    }

    // Carta sem efeitos espeficiais
    public void carta_Comum()
    {
        writeln("Carta comum sem efeitos");
    }

    // Métodos para cada carta
    void carta_Zero()
    {
        writeln("Jogou a carta Zero.");
    }

    void carta_Um()
    {
        writeln("Jogou a carta Um.");
    }

    void carta_Bloqueio(ListaJogadores jogadores)
    {
        writeln("Jogou a carta Bloqueio.");
        jogadores.setJogadorVezProximo();
    }

    void carta_Mais2(ListaJogadores jogadores)
    {
        writeln("Jogou a carta Mais 2.");
        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 2);
    }

    void carta_Joker(Carta carta)
    {
        writeln("Jogou a carta Joker.");
        string[] arrayCores = ["Vermelho", "Azul", "Verde", "Amarelo"];
        string corDaCarta = DataInput.SelecionarCor(arrayCores, 4, "Digite um numero: ");
        carta.setCor(corDaCarta);
    }

    void carta_JokerMais4(Carta carta, ListaJogadores jogadores)
    {
        writeln("Jogou a carta Joker +4.");
        string[] arrayCores = ["Vermelho", "Azul", "Verde", "Amarelo"];
        string corDaCarta = DataInput.SelecionarCor(arrayCores, 4, "Digite um numero: ");
        carta.setCor(corDaCarta);
        uno.getBaralho().distribuirCartaJogador(jogadores.getJogadorVezProximo(), 4);
        
    }

    public bool verficiarSeJogoEstaFinalizado()
    {
        // Todo Implementar
        return false;
    }

}
