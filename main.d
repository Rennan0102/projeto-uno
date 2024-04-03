import std.stdio;
import std.container;

import entidades.Carta;
import entidades.Uno;
import entidades.Baralho;
import entidades.Jogador;

void main(){

    Uno.main();
    Baralho.inicializarBaralho();

    foreach (Carta carta; Baralho.getCartasBaralho()){
        if (typeid(carta) != typeid(CartaJoker)){
            CartaComum cartaComum = cast(CartaComum) carta;
            //writeln("Carta ", cartaComum.getNome(), " | Cor ", cartaComum.getCor());
            cartaComum.mostrarCarta();
        }
        else{
            //writeln("Carta ", carta.getNome());
            carta.mostrarCarta();
        }
    }

    writeln(Baralho.getCartasBaralho().length);

    Jogador j1 = new Jogador("Rennan");
    Baralho.distribuirCartas(j1, 7);

}
