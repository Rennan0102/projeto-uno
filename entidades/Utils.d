module entidades.Utils;

import std.stdio;
import std.algorithm;
import std.array;
import std.algorithm.iteration : map;
import std.conv : to;
import std.random;
import entidades.Jogador;
import entidades.Carta;

export class ArrayList(T)
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
        if (index < 0 || index > size)
        {
            throw new Exception("Index out of bounds");
        }

        array = array[0 .. index] ~ [element] ~ array[index .. $];
        size++;
    }

    T get(int index)
    {
        if (index < 0 || index >= size)
        {
            throw new Exception("Index out of bounds");
        }

        return array[index];
    }

    void remove(int index)
    {
        if (index < 0 || index >= size)
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

    T pop()
    {
        assert(size > 0, "Array vazio");

        auto lastIndex = size - 1;
        auto element = array[lastIndex];

        array = array[0 .. lastIndex];

        size--;

        return element;
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

    void shuffle()
    {
        randomShuffle(array);
    }

    public T[] toArray()
    {
        return array;
    }

    alias array this;
}

export class Stack(T)
{
    private T[] data;
    private int size;

    this()
    {
        data = [];
    }

    void push(T value)
    {
        data ~= value;
        size++;
    }

    T pop()
    {
        assert(!isEmpty(), "Stack is empty");
        T value = data[size - 1];
        data = data[0 .. size - 1];
        size--;
        return value;
    }

    T getLast()
    {
        return data[size - 1];
    }

    int getSize()
    {
        return size;
    }

    bool isEmpty()
    {
        return size == 0;
    }

    void shuffle()
    {
        randomShuffle(data);
    }
}

export class DataInput
{
    public static string stringSaida = "-s";

    public static string SelecionarCor(string[] elements, int sizeArray, string label)
    {

        writeln(label);

        int i = 0;

        foreach (element; elements.map!(to!string))
        {
            writeln(++i, ": ", element);
        }

        int selection;
        string input;

        while (true)
        {

            try
            {
                write("Digite o numero: ");
                input = readln();
                input = input.replace("\n", "");

                selection = to!int(input);

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


    public static T SelecionarElemento(T)(T[] elements, int sizeArray, string label)
    {

        writeln(label);

        int i = 0;

        foreach (element; elements.map!(to!string))
        {
            writeln(++i, ": ", element);
        }

        int selection;
        string input;

        while (true)
        {

            try
            {
                write("Digite o numero: ");
                input = readln();
                input = input.replace("\n", "");

                selection = to!int(input);

                if (selection == 0){
                    T coisa = new T();
                    return coisa;
                }

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
export class JogadaInvalidaException : Exception
{

    this(string mensagem)
    {
        super(mensagem);
    }

}

class Node(T)
{
    T data;
    Node!T proximo;
    Node!T anterior;

    this(T data)
    {
        this.data = data;
        this.proximo = null;
        this.anterior = null;
    }
}

class ListaJogadores
{
public:
    Node!Jogador inicio;
    Node!Jogador fim;
    Node!Jogador vez;
    int tamanho;

public:
    this()
    {
        this.inicio = null;
        this.fim = null;
        this.vez = null;
        this.tamanho = 0;
    }

    void add(Jogador jogador)
    {
        Node!Jogador novoNo = new Node!Jogador(jogador);

        if (this.inicio is null)
        {
            this.inicio = novoNo;
            this.fim = novoNo;
            this.vez = novoNo;
        }
        else
        {
            this.fim.proximo = novoNo;
            novoNo.anterior = this.fim;
            this.fim = novoNo;
        }

        this.fim.proximo = this.inicio;
        this.inicio.anterior = this.fim;

        this.tamanho++;
    }

public:
    int length()
    {
        return this.tamanho;
    }

    Jogador[] toArray()
    {
        Jogador[] array = new Jogador[](this.tamanho);

        Node!Jogador atual = this.inicio;

        for (int i = 0; i < this.tamanho; i++)
        {
            array[i] = atual.data;
            atual = atual.proximo;
        }

        return array;
    }

public:
    Jogador setJogadorVezProximo()
    {
        this.vez = vez.proximo;

        return vez.data;
    }

    Jogador setJogadorVezAnterior()
    {
        this.vez = vez.anterior;

        return vez.data;
    }

    Jogador getJogadorVezProximo(){ // Foi nóis :D
        return vez.proximo.data;
    }

    private Node!Jogador getJogadorNode(int posicao)
    {

        if (posicao < 0 || posicao >= this.tamanho)
        {
            throw new Exception("Posição inválida");
        }

        Node!Jogador atual = this.inicio;

        for (int i = 0; i < posicao; i++)
        {
            atual = atual.proximo;
        }

        return atual;
    }

    Jogador getJogadorVez()
    {
        return vez.data;
    }

    void sortearJogadorVez()
    {
        int index = uniform(0, tamanho);

        this.vez = getJogadorNode(index);
    }

}
