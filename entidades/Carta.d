module entidades.Carta;

export class Carta {
    
    protected string nome;
    protected EnumCarta tipoCarta;  

    public this(EnumCarta tipoCarta, string nome) {
        this.tipoCarta = tipoCarta;
        this.nome = nome;
    } 

}

export class CartaComum : Carta {

    private EnumCorCarta cor;

     public this(EnumCarta tipoCarta, string nome, EnumCorCarta cor) {
        super(tipoCarta, nome);
        this.cor = cor;
    } 

}

export class CartaEspecial : Carta {

} 

export class CartaJoker : Carta {

} 