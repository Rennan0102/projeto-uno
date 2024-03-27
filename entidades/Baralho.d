module entidades.Baralho;

import entidades.Jogador;
import entidades.Uno;
import entidades.Carta;

export class Baralho {
    static Carta[] cartasBaralho;

    static this(){
        cartasBaralho = Uno.getCartas();
    }

    public void distribuirCartas(Jogador jogador, int numeroCartas) {
        Carta[] cartasDoJogador = cartas.take(numeroCartas).array();

        // Remover as cartas atribuídas do baralho principal
        cartas = cartas[$-numeroCartas .. $]; 

        foreach (Carta carta; cartasDoJogador) {
            jogador.adicionarCarta(carta);
        }
  }
}