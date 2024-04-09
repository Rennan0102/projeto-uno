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
  public static int NUMERO_CARTAS_JOGADOR = 4;

  private Baralho baralho;
  private ListaJogadores jogadores;
  private Stack!(Carta) cartasUsadas;
  private bool jogoEncerrado;
  private bool sentidoInvertidoRotacao;
  private RegrasUno regrasUno;
  private int totalJogadas;

  public this(RegrasUno regrasUno)
  {
    this.baralho = new Baralho();
    this.cartasUsadas = new Stack!(Carta)();
    this.jogadores = new ListaJogadores();
    this.sentidoInvertidoRotacao = false;
    this.jogoEncerrado = false;
    this.regrasUno = regrasUno;
    this.totalJogadas = 0;
  }

  public void telaInicial()
  {

    int tempo = 3;

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

    writeln();
    writeln();

    writeln("O jogo irá começar em", tempo, "segundos...");

    Thread.sleep(dur!"seconds"(tempo));

  }

  public void gerarJogadores()
  {

    int count = 1;
    string nomeJogador;

    while (true)
    {

      if (toLower(nomeJogador) == DataInput.stringSaida || count > MAXIMO_JOGADORES - 1)
      {
        break;
      }

      writef("Digite o nome do jogador %d \n", count);
      readf("%s\n", &nomeJogador);

      jogadores.add(new JogadorReal(nomeJogador));
      count++;
    }

    //jogadores.add(new Bot("Burrinho Artificial"));
  }

  public void distribuirCartaJogadores()
  {
    writeln();
    writeln("Distribuindo Cartas...");
    Thread.sleep(dur!"seconds"(1));

    foreach (ref jogador; jogadores.toArray())
    {
      this.baralho.distribuirCartaJogador(jogador, NUMERO_CARTAS_JOGADOR);
    }

  }

  public void adicionarPrimeiraCartaPilhaDescarte()
  {
    Carta carta = baralho.getCartasBaralho().pop();

    cartasUsadas.push(carta);
  }

  public void comecarJogo()
  {

    Carta carta;
    Jogador jogadorVez;
    bool possuiCartaValida, jogadaValida;
    int totalCartasJogador;

    while (!jogoEncerrado)
    {

      jogadorVez = jogadores.getJogadorVez();
      totalCartasJogador = jogadorVez.getMaoCartas().length();
      possuiCartaValida = false;
      jogadaValida = false;

      writeln("Carta do Topo da Pilha de Descarte: " ~ cartasUsadas.getLast().toString());
      writeln();

      writeln("Vez do Jogador: " ~ jogadorVez.toString());
      writeln("\n");

      for (int x = 0; x < totalCartasJogador; x++)
      {
        Carta cartaAtual = jogadorVez.getMaoCartas().get(x);

        try
        {
          regrasUno.testarCartaValida(cartaAtual);
          possuiCartaValida = true;
          break;
        }
        catch (JogadaInvalidaException error)
        {
        }
      }

      if (!possuiCartaValida)
      {
        Carta cartaComprada = baralho.getCartasBaralho().pop();

        try
        {
          regrasUno.jogarCarta(cartaComprada);
          cartasUsadas.push(cartaComprada);
        }
        catch (JogadaInvalidaException)
        {
          writeln("Não possui carta valida, mesmo comprando, indo pro proximo....");

          jogadorVez.adicionarCarta(cartaComprada);
          jogadores.mudarVezJogador();
        }

        continue;
      }

      while (!jogadaValida)
      {

        carta = jogadorVez.jogar();

        try
        {
          regrasUno.jogarCarta(carta);
          jogadaValida = true;
        }
        catch (JogadaInvalidaException error)
        {
          writefln("Error: " ~ error.msg);
          continue;
        }

      }

      jogadorVez.removerCarta(carta);
      cartasUsadas.push(carta);

      bool jogoFinalizado = regrasUno.verficiarSeJogoEstaFinalizado();

      if (jogoFinalizado)
      {
        jogoEncerrado = true;
        continue;
      }

      string nomeCarta = carta.getNome();

      if (nomeCarta == "Bloqueio" || nomeCarta == "Mais2" || nomeCarta == "JokerMais4")
      {
        jogadores.pularVezJogador();
      }
      else
      {
        jogadores.mudarVezJogador();
      }

    }
  }

  public void main()
  {
    this.telaInicial();

    this.baralho.gerarCartas();
    this.baralho.embaralharCartas();

    this.gerarJogadores();
    this.distribuirCartaJogadores();

    this.jogadores.sortearJogadorVez();

    this.adicionarPrimeiraCartaPilhaDescarte();
    this.comecarJogo();
  }

  // -----------------------------------------------------------------------------------------------------------
  // Get e Setters

  public Jogador getJogadorVez()
  {
    return this.jogadores.getJogadorVez();
  }

  public Baralho getBaralho()
  {
    return baralho;
  }

  public void setBaralho(Baralho novoBaralho)
  {
    baralho = novoBaralho;
  }

  public ListaJogadores getJogadores()
  {
    return this.jogadores;
  }

  public Stack!Carta getCartasUsadas()
  {
    return cartasUsadas;
  }

  public void setCartasUsadas(Stack!Carta novasCartasUsadas)
  {
    cartasUsadas = novasCartasUsadas;
  }

  public bool getJogoEncerrado()
  {
    return jogoEncerrado;
  }

  public void setJogoEncerrado(bool novoJogoEncerrado)
  {
    jogoEncerrado = novoJogoEncerrado;
  }

  public bool getsentidoInvertidoRotacao()
  {
    return sentidoInvertidoRotacao;
  }

  public void setsentidoInvertidoRotacao(bool novosentidoInvertidoRotacao)
  {
    sentidoInvertidoRotacao = novosentidoInvertidoRotacao;
  }

}
