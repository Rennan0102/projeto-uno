import std.stdio;
import entidades.Carta;
import entidades.Uno;

void main()
{

    Uno uno = new Uno();

    uno.main();

    foreach (Carta carta; uno.getCartas())
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

    writeln(uno.getCartas().length);

}
