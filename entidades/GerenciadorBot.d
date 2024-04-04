module entidades.GerenciadorBot;

import entidades.Bot;
import entidades.Carta;

class GerenciadorBot {
    // Método para efetuar a jogada do bot
    public void efetuarJogada(Bot bot, Carta[] cartasDescarte) {
        Carta ultimaCartaDescarte = cartasDescarte.front();
        
        // Verifica se o bot tem alguma carta compatível para jogar
        auto cartaJogada = bot.checarCor(ultimaCartaDescarte.getCor()) 
            || bot.checarNome(ultimaCartaDescarte.getNome())
            || bot.checarEspecial();

        if (cartaJogada !is null) {
            // Jogar a carta
            // precisamos ver como será a class partida
        } else {
            // Se o bot não tiver carta para jogar, ele pega uma carta do baralho
            auto cartaNova = pegarCarta(baralho);
            bot.adicionarCarta(cartaNova);
            // Aqui você pode adicionar a lógica para imprimir na tela ou atualizar o estado do jogo informando que o bot comprou uma carta
        }
    }

    // Método para pegar uma carta do baralho
    private Carta pegarCarta(Carta[] baralho) {
        if (!baralho.empty) {
            return baralho.front();
        } else {
            // Baralho está vazio, não há mais cartas para pegar
            // tem que fazer partida
            return null;
        }
    }

    // Método para verificar se o bot tem apenas uma carta na mão (Uno)
    public bool checaUno(Bot bot, Carta[] maoCartas) {
        return maoCartas.length == 1;
    }
}
