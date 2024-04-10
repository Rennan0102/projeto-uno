module entidades.Carta;

import std.stdio;
import entidades.Jogador;
import std.format;


export class Carta
{
    private string nome, cor;

    public this()
    {
    }

    public this(string nome, string cor)
    {
        this.nome = nome;
        this.cor = cor;
    }

    public string getNome()
    {
        return nome;
    }

    public string getCor() const
    {
        return cor;
    }

    public void setCor(string novaCor)
    {
        cor = novaCor;
    }

    override string toString() const
    {
        if (this.cor != null)
        {
            string print = format("%-13s["~cor~"]", "[" ~ nome ~ "]");
            return print;
        }

        return "[" ~ nome ~ "]";
    }
}