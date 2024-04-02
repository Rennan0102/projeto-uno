import std.stdio;
import entidades.Carta;
import entidades.Uno;
import entidades.Baralho;
import entidades.Jogador;
import std.container;

void main(){

    Uno.main();
    foreach (Carta carta; Uno.getCartas())
    {
        if (typeid(carta) != typeid(CartaJoker))
        {
            CartaComum cartaComum = cast(CartaComum) carta;
            writeln("Carta ", cartaComum.getNome(), " | Cor ", cartaComum.getCor());
        }
        else
        {
            writeln("Carta ", carta.getNome());
        }
    }

    writeln(Uno.getCartas().length);

    Jogador j1 = new Jogador("Ren", true);
    Baralho.distribuirCartas(j1, 7);

}
