module entidades.Utils;

import std.stdio;
import std.algorithm.iteration : map;
import std.conv : to;

class Stack(T)
{
    private T[] data;

    this()
    {
        data = [];
    }

    void push(T value)
    {
        data ~= value;
    }

    T pop()
    {
        assert(!isEmpty(), "Stack is empty");
        T value = data[$ - 1];
        data = data[0 .. $ - 1];
        return value;
    }

    bool isEmpty()
    {
        return data.length == 0;
    }
}

class DataInput
{
    public static string stringSaida = "-s";

    T SelecionarElemento(T)(T[] elements)
    {
        writeln("Selecione um elemento da lista:");
        foreach (i, element; elements.map!(to!string))
        {
            writeln(i + 1, ": ", element);
        }

        int selection;

        while (true)
        {

            try
            {
                write("Digite o número correspondente ao elemento desejado: ");
                readf("%d", &selection);

                if (selection >= 1 && selection < elements.length)
                {
                    return elements[selection];
                }
                else
                {
                    writeln("Índice inválido. Tente novamente.");
                }
            }
            catch (Exception e)
            {
                writeln("Entrada inválida. Tente novamente.");
            }

        }

    }

}
