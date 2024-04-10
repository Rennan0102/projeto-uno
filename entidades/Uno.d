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
  public static int MAXIMO_JOGADORES = 4;
  public static int NUMERO_CARTAS_JOGADOR = 7;

  private Baralho baralho;
  private ListaJogadores jogadores;
  private Stack!(Carta) cartasUsadas;
  private bool jogoEncerrado;
  private bool sentidoInvertidoRotacao;
  private RegrasUno regrasUno;
  private int totalJogadas;
  private Jogador vencedor;

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
    string nomeJogador;

    writef("Digite o nome do jogador 1: \n");
    readf("%s\n", &nomeJogador);

    jogadores.add(new JogadorReal(nomeJogador));
    
    for (int i = 0; i < MAXIMO_JOGADORES - 1; i++){
      jogadores.add(new Bot("Burrinho Artificial " ~ to!string(i + 1)));
    }
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
    Decoracao.aMimir(1);
    if (baralho.getCartasBaralho().getLast().getNome() != "Joker" && baralho.getCartasBaralho().getLast().getNome() != "JokerMais4"){
      Carta carta = baralho.getCartasBaralho().pop();
      cartasUsadas.push(carta);
    } else {
      writeln("Carta de inicializacao invalida. Comprando outra...");
      Decoracao.aMimir(1);
      baralho.embaralharCartas();
      adicionarPrimeiraCartaPilhaDescarte();
    }
  }

  public void comecarJogo()
  {

    Carta carta;
    Jogador jogadorVez;
    bool possuiCartaValida;
    int totalCartasJogador;
    Carta cartaTopoPilha;

    while (!jogoEncerrado)
    {

      jogadorVez = jogadores.getJogadorVez();
      totalCartasJogador = jogadorVez.getMaoCartas().length();
      cartaTopoPilha = cartasUsadas.getLast();
      possuiCartaValida = false;

      writeln("Última carta jogada: " ~ cartaTopoPilha.toString());
      writeln();

      writeln("Vez do Jogador: " ~ jogadorVez.toString());

      for (int x = 0; x < totalCartasJogador; x++)
      {
        Carta cartaAtual = jogadorVez.getMaoCartas().get(x);

        try
        {
          this.testarCartaValida(cartaAtual);
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
          // colocar um print de comprar carta e jogou tal carta
          regrasUno.jogarCarta(cartaComprada);
          cartasUsadas.push(cartaComprada);
        }
        catch (JogadaInvalidaException)
        {
          writeln("Não possui carta valida, mesmo comprando, indo pro proximo....");

          jogadorVez.adicionarCarta(cartaComprada);
          jogadorVez.mostrarMaoCartas();

          jogadores.mudarVezJogador();
          writeln();
        }

        continue;
      }

      carta = jogadorVez.jogar(this);

      regrasUno.jogarCarta(carta);
      jogadorVez.removerCarta(carta);
      cartasUsadas.push(carta);

      bool jogoFinalizado = regrasUno.verficiarSeJogoEstaFinalizado(jogadorVez);

      if (jogoFinalizado)
      {
        vencedor = jogadorVez;
        jogoEncerrado = true;
        continue;
      }

    }
  }

  public void testarCartaValida(Carta carta)
  {
    Carta cartaTopoPilha = this.getCartasUsadas().getLast();

    string nomeCartaTopoPilha = cartaTopoPilha.getNome();
    string corCartaTopoPilha = cartaTopoPilha.getCor();

    string nomeCarta = carta.getNome();
    string corCarta = carta.getCor();

    if ((nomeCartaTopoPilha == "Joker" || corCartaTopoPilha == "JokerMais4") && corCarta != corCartaTopoPilha)
    {
      throw new JogadaInvalidaException("A cor tem que ser igual a selecionada pelo o player");
    }

    if (
      nomeCarta != "Joker" &&
      nomeCarta != "JokerMais4" &&
      nomeCarta != nomeCartaTopoPilha &&
      corCarta != corCartaTopoPilha
      )
    {
      throw new JogadaInvalidaException("Jogada Inválida");
    }
  }

  public void mostrarVencedor()
  {
    writeln(vencedor, "Venceu o jogo");
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
    this.mostrarVencedor();
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
