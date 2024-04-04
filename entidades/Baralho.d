module entidades.Baralho;

import entidades.Jogador;
import entidades.Carta;

import std.container;
import std.range;
import std.random;

export class Baralho
{
    private string[] cartasNumeracao;
    private string[] cartaEspecial;
    private string[] corCarta;
    private string[] cartaSentido;
    private string[] jokers;

    private Carta[] cartasBaralho;

    this()
    {
        this.cartasNumeracao = [
            "Zero", "Um", "Dois", "Tres", "Quatro", "Cinco", "Seis", "Sete",
            "Oito",
            "Nove"
        ];
        this.cartaEspecial = [
            "Bloqueio", "Inverter", "Mais2"
        ];
        this.jokers = ["Joker", "JokerMais4"];
        this.corCarta = ["Vermelho", "Azul", "Verde", "Amarelo"];
        this.cartaSentido = ["Esquerda", "Direita"]; // checar dps
        this.cartasBaralho = [];
    }

    public void gerarCartas()
    {
        // Cartas numeradas de 0 a 9 para cada cor
        foreach (cor; corCarta)
        {
            foreach (numero; cartasNumeracao)
            {
                if (numero == "Zero")
                {
                    cartasBaralho ~= new CartaComum(numero, cor);
                }
                else
                {
                    cartasBaralho ~= new CartaComum(numero, cor);
                    cartasBaralho ~= new CartaComum(numero, cor);
                }
            }
        }

        // Cartas especiais
        foreach (cor; corCarta)
        {
            foreach (especial; cartaEspecial)
            {
                cartasBaralho ~= new CartaComum(especial, cor);
                cartasBaralho ~= new CartaComum(especial, cor);
            }
        }

        // Cartas coringas
        foreach (joker; this.jokers)
        {
            foreach (_; 0 .. 4)
            {
                cartasBaralho ~= new CartaJoker(joker);
            }
        }
    }

    public void distribuirCartaJogador(Jogador jogador, int numeroCartas)
    { // Cartas sempre retiradas do final do ArrayList
        Carta[] cartasDoJogador = cartasBaralho.take(numeroCartas);

        // Remover as cartas atribuídas do baralho principal
        for (int i = 0; i < numeroCartas; i++)
        {
            cartasBaralho.popFront();
        }

        // Adiciona as cartas na mão do Jogador
        foreach (Carta carta; cartasDoJogador)
        {
            jogador.adicionarCarta(carta);
        }
    }

    public void reporCarta(Carta[] cartasDescarte)
    { // Método para adicionar as cartas do descarte no baralho
        foreach (ref carta; cartasDescarte)
        {
            cartasBaralho ~= carta;
        }
    }

    public void embaralharCartas()
    {
        randomShuffle(cartasBaralho);
    }

    // Getter
    public Carta[] getCartasBaralho()
    {
        return cartasBaralho;
    }
}
