module entidades.Uno;

import std.stdio;
import std.conv;
import std.range;
import entidades.Carta;
import entidades.Jogador;
import entidades.Baralho;
import entidades.RegrasUno;
import entidades.Utils;
import std.string;
import std.random : uniform, uniform01;
import core.thread;

export class Uno
{
  public static int MAXIMO_JOGADORES = 3;
  public static int NUMERO_CARTAS_JOGADOR = 8;
  public static numeroCartaEspecial = 8;
  public static numeroCartaJoker = 4;

  private Baralho baralho;
  private Jogador[] jogadores;
  private Stack!Carta cartasUsadas;
  private Jogador jogadorVez;
  private bool jogoEncerrado;
  private bool sentidoInvertido;
  private RegrasUno regrasUno;

  public this(RegrasUno regrasUno)
  {
    this.baralho = new Baralho();
    this.cartasUsadas = new Stack!Carta();
    this.jogadores = [];
    this.sentidoInvertido = false;
    this.jogoEncerrado = false;
    this.regrasUno = regrasUno;
  }

  public Carta[] getCartas()
  {
    return this.baralho.getCartasBaralho();
  }

  public void telaInicial()
  {
    {

      writeln("\n--------------------------------------------------------------------------------");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhyso+++osyhdhhhhhhhhh");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhyo:.......```-/shhhhhhhh");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhy+..````.....````.:shhhhhh");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhy:````-/osysso+:.```.+hhhhh");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhyso/-.shhhhh:````/yddmddhhys+-..../hhhh");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhys:....-yhhds-```-ydhhhhddmhyho-....shhh");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhyyhhhhhhhdhs+-````/hddo.  `-hhhhhhhhhmmdh/----:hhh");
      writeln("hhhhhhhhhhhhhhhhhhhhhhhhhhys+:-.-+shhhhdmys+.````+dds- ``.shhhhhhhhhmmd/::::-hhh");
      writeln("hhhhhhhhhhhhhhhhhhhyso/:shs/-``````-+shhdmhy/.  `.hhy/```.-yhhhhhhhhdmh-::::/hhh");
      writeln("hhhhhhhhhhhhhhhhhhy/-...-hso:`````````-+sdmhh/````-hs+:.----oyhhhhhhhy::::::yhhh");
      writeln("hhhhhhhhyyhhhhhhhdso:````:hs+:````-.`   `-oyhy:..../so+/::::-:/oooo/::::::/shhhh");
      writeln("hhhhys+:--yhhhhhhmhs+-````oys+-`  `:/:.````.-+/:----os+++/::::::::::::::/oyhhhhh");
      writeln("hhhhs:```./hhhhhhdmys/.```.yys/.```.+so+/-------::::-yhssso++///:::::/+shhhhhhhh");
      writeln("hhdhy+-```.+hhhhhhdmys:````-hyy/....-yyysso/::::::::::dddhyyyyyssssyhdddhhhhhhhh");
      writeln("hhdmhy/-```-shhhhhhddys:``..:dys:----:dddhhyyo+/::::::/hddddddmdmmmmddhhhhhhhhhh");
      writeln("hhhdmys:.```-yhhhhhhmdhs:..-.odho::::-+hdmmdddhyo+/////shhhhdddddhhhhhhhhhhhhhhh");
      writeln("hhhhddyo:.```:hhhhhhdmdd+:-:-.mhh+::::-ohhddmmdddhysyyhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhmhy+:....+hhhhhhdmd+::::.hmdh/::::-yhhhhddmmdddddhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhdmhy+:---.+yhhhhhds-:::::hdmdh/:/++ohhhhhhhddhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhhdms++:-----/+o+/:-:::::shhmddyyhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhhhddoo+/::::----:::::/+yhhhdmdmmddhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhhhhddysso//:::::://+shhhhhhhddhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhhhhhdmdddhhyyyyyhhdmdhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhhhhhhhdhhhhhhhhhhddhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      writeln("hhhhhhhhhhhhhhhdddhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    }
  }

  public void gerarJogadores()
  {

    int count = 1;
    string nomeJogador;

    while (true)
    {

      writef("Digite o nome do jogador %d \n", count);
      readf("%s\n", &nomeJogador);

      if (toLower(nomeJogador) == DataInput.stringSaida || count > MAXIMO_JOGADORES - 1)
      {
        break;
      }

      jogadores ~= new JogadorReal(nomeJogador);
      count++;
    }

    ///jogadores ~= new Bot("Burrinho Artificial");
  }

  public void distribuirCartaJogadores()
  {
    writeln("Distribuindo Cartas...");
    Thread.sleep(dur!"seconds"(1));

    foreach (ref jogador; jogadores)
    {
      this.baralho.distribuirCartaJogador(jogador, NUMERO_CARTAS_JOGADOR);
    }

  }

  public void mostrarJogadores()
  {
    foreach (jogador; jogadores)
    {
      writeln(jogador);
      jogador.mostrarMaoCartas();
    }

    writeln(this.baralho.getCartasBaralho());
  }

  public void sortearJogador()
  {
    size_t index = uniform(0, jogadores.length);

    this.jogadorVez = jogadores[index];
    vezJogador(jogadorVez);
  }

  // Provavelmente isso não vai ficar aqui 
  public void comecarJogo()
  {
    size_t index = uniform(0, baralho.getCartasBaralho.length);
    Carta cartaJogada = baralho.getCartasBaralho()[index];
    cartasUsadas.push(cartaJogada);
    writeln(cartaJogada);
  }

  public void main()
  {
    this.baralho.gerarCartas();
    this.baralho.embaralharCartas();

    this.gerarJogadores();
    this.distribuirCartaJogadores();

    this.comecarJogo();
    
    while (!jogoEncerrado){
      this.sortearJogador();
    }

    // Vez começa no Fluxo Inicial, com as cartas sendo embaralhadas e distribuídas
    // O baralho coloca uma carta na pilha de usados e começa o Fluxo Normal
  }
    // Fluxo Normal: Tem uma carta na pilha de usados, jogador vê a mão, escolhe Carta
    // ou escolhe comprar, joga a carta e passa a vez

  public void vezJogador(Jogador jogador){
    writeln("Sua vez!");
    Carta ultimoCartaJogada = this.cartasUsadas.getLast();
    writeln("Ultima carta jogada: " ~ to!string(ultimoCartaJogada));
    // Checar se o baralho está vazio, se sim, repor as cartas

    cartasUsadas.push(jogador.jogar());
  }

  // Get e Setters
  public Baralho getBaralho()
  {
    return baralho;
  }

  public void setBaralho(Baralho novoBaralho)
  {
    baralho = novoBaralho;
  }

  public Jogador[] getJogadores()
  {
    return jogadores;
  }

  public void setJogadores(Jogador[] novosJogadores)
  {
    jogadores = novosJogadores;
  }

  public Stack!Carta getCartasUsadas()
  {
    return cartasUsadas;
  }

  public void setCartasUsadas(Stack!Carta novasCartasUsadas)
  {
    cartasUsadas = novasCartasUsadas;
  }

  public Jogador getJogadorVez()
  {
    return jogadorVez;
  }

  public void setJogadorVez(Jogador novoJogadorVez)
  {
    jogadorVez = novoJogadorVez;
  }

  public bool getJogoEncerrado()
  {
    return jogoEncerrado;
  }

  public void setJogoEncerrado(bool novoJogoEncerrado)
  {
    jogoEncerrado = novoJogoEncerrado;
  }

  public bool getSentidoInvertido()
  {
    return sentidoInvertido;
  }

  public void setSentidoInvertido(bool novoSentidoInvertido)
  {
    sentidoInvertido = novoSentidoInvertido;
  }

}
