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
import std.exception;

export class Uno
{
  public static int MAXIMO_JOGADORES = 3;
  public static int NUMERO_CARTAS_JOGADOR = 8;
  public static numeroCartaEspecial = 8;
  public static numeroCartaJoker = 4;

  private Baralho baralho;
  private ArrayList!(Jogador) jogadores;
  private Stack!(Carta) cartasUsadas;
  private Jogador jogadorVez;
  private bool jogoEncerrado;
  private bool sentidoInvertido;
  private RegrasUno regrasUno;
  private int totalJogadas;

  public this(RegrasUno regrasUno)
  {
    this.baralho = new Baralho();
    this.cartasUsadas = new Stack!(Carta)();
    this.jogadores = new ArrayList!(Jogador)();
    this.sentidoInvertido = false;
    this.jogoEncerrado = false;
    this.regrasUno = regrasUno;
    this.totalJogadas = 0;
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

      jogadores.add(new JogadorReal(nomeJogador));
      count++;
    }

    //jogadores.add(new Bot("Burrinho Artificial"));
  }

  public void distribuirCartaJogadores()
  {
    writeln("Distribuindo Cartas...");
    Thread.sleep(dur!"seconds"(1));

    foreach (ref jogador; jogadores.toArray())
    {
      this.baralho.distribuirCartaJogador(jogador, NUMERO_CARTAS_JOGADOR);
    }

  }

  public void sortearVezJogador()
  {
    int index = uniform(0, jogadores.length());

    totalJogadas = index;

    this.jogadorVez = jogadores.get(index);
  }

  public void adicionarPrimeiraCartaPilhaDescarte()
  {
    Carta carta = baralho.getCartasBaralho().pop();

    cartasUsadas.push(carta);
  }

  public void comecarJogo()
  {
    writeln("Carta do Topo da Pilha de Descarte: " ~ cartasUsadas.getLast().toString());
    writeln();

    while (!jogoEncerrado)
    {
      writeln("Vez do Jogador: " ~ jogadorVez.toString());
      writeln("\n");

      Carta carta = jogadorVez.jogar();

      try
      {
        regrasUno.jogarCarta(carta);
      }
      catch (JogadaInvalidaException error)
      {
        writefln("Error: " ~ error.msg);
        continue;
      }

      jogadorVez.removerCarta(carta);
      cartasUsadas.push(carta);

      bool jogoFinalizado = regrasUno.verficiarSeJogoEstaFinalizado();

      if (jogoFinalizado)
      {
        jogoEncerrado = true;
        continue;
      }

      mudarVezJogador();
      writeln();
    }
  }

  // Corrigir depois
  public void mudarVezJogador()
  {
    int indice;
    totalJogadas++;

    if (sentidoInvertido)
    {
      indice = (jogadores.length() - 1) - totalJogadas;
    }
    else
    {
      indice = totalJogadas % jogadores.length();
    }

    this.jogadorVez = jogadores.get(indice);
  }

  public void main()
  {
    this.baralho.gerarCartas();
    this.baralho.embaralharCartas();

    this.gerarJogadores();
    this.distribuirCartaJogadores();

    this.sortearVezJogador();
    this.adicionarPrimeiraCartaPilhaDescarte();

    this.comecarJogo();
  }

  // -----------------------------------------------------------------------------------------------------------
  // Get e Setters

  public Baralho getBaralho()
  {
    return baralho;
  }

  public void setBaralho(Baralho novoBaralho)
  {
    baralho = novoBaralho;
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
