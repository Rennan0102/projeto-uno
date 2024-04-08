module entidades.Carta;

import std.stdio;
import entidades.Jogador;

export class Carta {
    private string nome, cor;

    public this(){}    

    public this(string nome, string cor){
        this.nome = nome;
        this.cor = cor;
    }

    public string getNome(){
        return nome;
    }

    public string getCor() const{
        return cor;
    }

    public void setCor(string novaCor) {
        cor = novaCor;
    }

    override string toString() const{
        if (this.getCor != null){
            return "Cor ["~cor~"] \t" ~ "Carta: ["~nome~"] \t";
        }

        return "Carta: ["~nome~"] \t";  
    }
}
/** 

export class CartaComum : Carta {
    private string cor;

    public this(string nome, string cor){
        super(nome);
        this.cor = cor;
    }

    // Getter
    public string getCor(){
        return cor;
    }

     override string toString() const
    {
      return (super.toString() ~ "Cor ["~cor~"]");  
    }
}

export class CartaJoker : Carta {
    private string possivelCor;

    public this(string nome) {
        super(nome);
        possivelCor = null;
    }

    // Getter and Setter
    public string getPossivelCor() {
        return possivelCor;
    }

    public void setPossivelCor(string novaCor) {
        possivelCor = novaCor;
    }

}*/