module entidades.Utils;

import std.stdio;
import std.algorithm;
import std.array;
import std.algorithm.iteration : map;
import std.conv : to;

class ArrayList(T)
{
    private T[] array;
    private int size;

    this()
    {
        this.array = [];
    }

    void add(T element)
    {
        array ~= element;
        size++;
    }

    void add(int index, T element)
    {
        if (index < 0 || index > array.length)
        {
            throw new Exception("Index out of bounds");
        }

        array = array[0 .. index] ~ [element] ~ array[index .. $];
        size++;
    }

    T get(int index)
    {
        if (index < 0 || index >= array.length)
        {
            throw new Exception("Index out of bounds");
        }

        return array[index];
    }

    void remove(int index)
    {
        if (index < 0 || index >= array.length)
        {
            throw new Exception("Index out of bounds");
        }
        array = array[0 .. index] ~ array[index + 1 .. $];
    }

    void remove(T element)
    {
        array = array.filter!(x => x !is element).array;
        size--;
    }

    void clear()
    {
        array = [];
        size = 0;
    }

    int length()
    {
        return size;
    }

    bool isEmpty()
    {
        return size == 0;
    }

    void print()
    {
        writeln(array);
    }

    public T[] toArray()
    {
        return array;
    }
}

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

    public static T SelecionarElemento(T)(T[] elements, int sizeArray, string label)
    {

        writeln(label);

        int i = 0;

        foreach (element; elements.map!(to!string))
        {
            writeln(++i, ": ", element);
        }

        int selection;
        

        while (true)
        {

            try
            {
                writeln("Digite o numero: \n");
                readf("%d", &selection);

                if (selection >= 1 && selection <= sizeArray)
                {
                    return elements[selection - 1];
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
