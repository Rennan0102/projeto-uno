module entidades.Bot;

import entidades.Carta;
import entidades.Jogador;

class Bot {
    private string nome;
    private Carta[] maoCartas;

    public this(string nome) {
        this.nome = nome;
        this.maoCartas = [];
    }

    // Método para adicionar uma carta à mão do bot
    public void adicionarCarta(Carta carta) {
        maoCartas ~= carta;
    }


    // Método para jogar uma carta com a cor desejada
    public Carta checarCor(string corDesejada) {
        foreach (Carta carta; maoCartas) {
            if (carta.getCor() == corDesejada) {
                maoCartas.remove(carta);
                return carta;
            }
        }
        //return null; // Retorna null se não encontrar uma carta com a cor desejada
    }

    // Método para jogar uma carta com o nome desejado
    public Carta checarNome(string nomeDesejado) {
        foreach (Carta carta; maoCartas) {
            if (carta.getNome() == nomeDesejado) {
                maoCartas.remove(carta);
                return carta;
            }
        }
        //return null; // Retorna null se não encontrar uma carta com o nome desejado
    }

    // Método para jogar uma carta especial (coringa)
    public Carta checarEspecial() {
        foreach (Carta carta; maoCartas) {
            if (carta is CartaJoker) {
                maoCartas.remove(carta);
                return carta;
            }
        }
       //return null; // Retorna null se não encontrar uma carta especial
    }

}
