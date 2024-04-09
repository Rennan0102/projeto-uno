module entidades.Baralho;

import entidades.Jogador;
import entidades.Carta;

import std.container;
import std.range;
import std.random;
import entidades.Utils;

export class Baralho
{
    public static string[] CARTAS_NUMERACAO = [
        "Zero", "Um", "Dois", "Tres", "Quatro", "Cinco", "Seis", "Sete",
        "Oito",
        "Nove"
    ];
    public static string[] CARTAS_ESPECIAIS = [
        "Bloqueio", "Inverter", "Mais2"
    ];
    public static string[] CARTAS_CORES = ["Vermelho", "Azul", "Verde", "Amarelo"];
    public static string[] CARTAS_JOKERS = ["Joker", "JokerMais4"];
    public static int NUMEROS_CARTAS_JOKER = 4;

    private ArrayList!(Carta) cartasBaralho;

    this()
    {
        this.cartasBaralho = new ArrayList!(Carta)();
    }

    public void gerarCartas()
    {
        // Cartas numeradas de 0 a 9 para cada cor
        foreach (cor; CARTAS_CORES)
        {
            foreach (numero; CARTAS_NUMERACAO)
            {
                if (numero == "Zero")
                {
                    cartasBaralho.add(new Carta(numero, cor));
                }
                else
                {
                    cartasBaralho.add(new Carta(numero, cor));
                    cartasBaralho.add(new Carta(numero, cor));
                }
            }
        }

        // Cartas especiais
        foreach (cor; CARTAS_CORES)
        {
            foreach (especial; CARTAS_ESPECIAIS)
            {
                cartasBaralho.add(new Carta(especial, cor));
                cartasBaralho.add(new Carta(especial, cor));
            }
        }

        // Cartas coringas
        foreach (joker; this.CARTAS_JOKERS)
        {
            foreach (_; 0 .. NUMEROS_CARTAS_JOKER)
            {
                cartasBaralho.add(new Carta(joker, null));
            }
        }
    }

    public void embaralharCartas()
    {
        cartasBaralho.shuffle();
    }

    public ArrayList!(Carta) getCartasBaralho()
    {
        return cartasBaralho;
    }

    public void distribuirCartaJogador(Jogador jogador, int numeroCartas)
    {

        for (int x = 0; x < numeroCartas; x++)
        {
            jogador.adicionarCarta(
                cartasBaralho.pop()
            );
        }

    }

}
