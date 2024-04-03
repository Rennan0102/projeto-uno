module entidades.Carta;

import std.stdio;
import entidades.Jogador;

export abstract class Carta {
    private string nome;

    public this(string nome){
        this.nome = nome;
    }

    public void mostrarCarta(){} // Método para printar a Carta
// Lembrar de colocar um índice na mão do jogador para ele poder escolher a carta
    public string getNome(){
        return nome;
    }
}

export class CartaComum : Carta {
    private string cor;

    public this(string nome, string cor){
        super(nome);
        this.cor = cor;
    }

    public override void mostrarCarta(){
        writeln(" ___________ ");
        writeln("|           |");
        writeln("|           |");
        writeln("| ", cor, "");
        writeln("|           |");
        writeln("|           |");
        writeln("| ", nome, "");
        writeln("|           |");
        writeln("|___________|");
    }

    // Getter
    public string getCor(){
        return cor;
    }
}

export class CartaJoker : Carta {
    public this(string nome) {
        super(nome);
    }

    public override void mostrarCarta(){
        writeln(" ___________ ");
        writeln("|           |");
        writeln("|           |");
        writeln("|           |");
        writeln("| ", nome, "");
        writeln("|           |");
        writeln("|           |");
        writeln("|           |");
        writeln("|___________|");
    }
}