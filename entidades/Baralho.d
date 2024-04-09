module entidades.Baralho;

import entidades.Jogador;
import entidades.Carta;

import std.container;
import std.range;
import std.random;
import entidades.Utils;

export class Baralho
{
    private string[] cartasNumeracao;
    private string[] cartaEspecial;
    private string[] corCarta;
    private string[] cartaSentido;
    private string[] jokers;
    private ArrayList!(Carta) cartasBaralho;

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
        this.cartasBaralho = new ArrayList!(Carta)();
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
        foreach (cor; corCarta)
        {
            foreach (especial; cartaEspecial)
            {
                cartasBaralho.add(new Carta(especial, cor));
                cartasBaralho.add(new Carta(especial, cor));
            }
        }

        // Cartas coringas
        foreach (joker; this.jokers)
        {
            foreach (_; 0 .. 4)
            {
                cartasBaralho.add(new Carta(joker, null));
            }
        }
    }

    public void embaralharCartas() {
        cartasBaralho.shuffle();
    }

    public ArrayList!(Carta) getCartasBaralho() {
        return cartasBaralho;
    }

    public void distribuirCartaJogador(Jogador jogador, int numeroCartas)
    { 

        for (int x = 0; x < numeroCartas; x++) {
            jogador.adicionarCarta(
               cartasBaralho.pop()      
            );
        }
    
    }

    public Carta getCarta() 

    {
        Carta carta =  cartasBaralho.get(0);
        cartasBaralho.remove(carta);
        return carta;

    }

  
}
