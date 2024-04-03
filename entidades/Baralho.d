module entidades.Baralho;

import entidades.Jogador;
import entidades.Uno;
import entidades.Carta;

import std.container;
import std.range;
import std.random;

export class Baralho {
    private static Carta[] cartasBaralho;

    public static void inicializarBaralho(){
        foreach (ref carta; Uno.getCartas()){ // Pega todas as cartas criadas em Uno e adiciona no baralho
            cartasBaralho ~= carta;
        }
    }

    public static void distribuirCartas(Jogador jogador, int numeroCartas) { // Cartas sempre retiradas do final do ArrayList
        Carta[] cartasDoJogador = cartasBaralho.take(numeroCartas);

        // Remover as cartas atribuídas do baralho principal
        for (int i = 0; i < numeroCartas; i++){
            cartasBaralho.popFront();
        }

        // Adiciona as cartas na mão do Jogador
        foreach (Carta carta; cartasDoJogador) {
            jogador.adicionarCarta(carta);
        }
    }

    public static void reporCarta(Carta[] cartasDescarte){ // Método para adicionar as cartas do descarte no baralho
        foreach (ref carta; cartasDescarte) {
            cartasBaralho ~= carta;
        }
    }

    public static void embaralharCartas(){
        randomShuffle(cartasBaralho);
    }

    // Getter
    public static Carta[] getCartasBaralho(){
        return cartasBaralho;
    }
}