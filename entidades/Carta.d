module entidades.Carta;

export abstract class Carta
{
    protected string nome;

    public this(string nome)
    {
        this.nome = nome;
    }

}

export class CartaComum : Carta
{

    private string cor;

    public this(string nome, string cor)
    {
        super(nome);
        this.cor = cor;
    }

}

export class CartaEspecial : Carta {
    public this(string nome) {
        super(nome);
    }
}

export class CartaJoker : Carta {

    public this(string nome) {
        super(nome);
    }
}




