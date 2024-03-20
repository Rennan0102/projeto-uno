module entidades.Carta;

export abstract class Carta
{
    protected string nome;

    public this(string nome)
    {
        this.nome = nome;
    }

    public string getNome() {
        return nome;
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

    public string getCor() {
        return cor;
    }
}

export class CartaJoker : Carta {

    public this(string nome) {
        super(nome);
    }
}




