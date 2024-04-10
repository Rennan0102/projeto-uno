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
  public static int MAXIMO_JOGADORES = 7;
  public static int NUMERO_CARTAS_JOGADOR = 7;

  private Baralho baralho;
  private ListaJogadores jogadores;
  private Stack!(Carta) cartasUsadas;
  private bool jogoEncerrado;
  private bool sentidoInvertidoRotacao;
  private RegrasUno regrasUno;
  private int totalJogadas;
  private Jogador vencedor;
  private string nomeJogador;

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

    int tempo = 4;
    write("\x1b[31m");

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
    writeln("--------------------------------------------------------------------------------");

    write("\x1b[0m");

    writeln();
    writeln();

    writeln("O jogo ira comecar em ", tempo, " segundos...");

    Decoracao.aMimir(tempo);

    Decoracao.limparTela();
  }

  public void gerarJogadores()
  {

    Decoracao.mensagemRetangulo("Criacao de Jogadores");

    writef("Digite o seu nome: \n");
    readf("%s\n", &nomeJogador);

     int numeroJogadores = 0;
     string input;

     while (numeroJogadores > MAXIMO_JOGADORES - 1 || numeroJogadores <= 0) {
        write("Digite o numero de bots: ");
        input = readln();
        input = input.replace("\n", "");
        numeroJogadores = to!int(input);
     }


    jogadores.add(new JogadorReal(nomeJogador));

    for (int i = 0; i < numeroJogadores; i++)
    {
      jogadores.add(new Bot("Burrinho Artificial " ~ to!string(i + 1)));
    }

    Decoracao.limparTela();
  }

  public void distribuirCartaJogadores()
  {

    foreach (ref jogador; jogadores.toArray())
    {
      this.baralho.distribuirCartaJogador(jogador, NUMERO_CARTAS_JOGADOR);
    }

  }

  public void mostrarJogadores()
  {

    Decoracao.mensagemRetangulo("Lista de Jogadores");

    auto jogadoresLista = jogadores.toArray();

    foreach (i, jogador; jogadoresLista)
    {
      writeln(++i, ". ", jogador.toString(), " -- ", NUMERO_CARTAS_JOGADOR, " Cartas");
    }
    

    Decoracao.aMimir(4);
    Decoracao.limparTela();
  }

  public void adicionarPrimeiraCartaPilhaDescarte()
  {

    Carta[] cartas = this.baralho.getCartasBaralho().toArray();

    for (int x = 0; x < cartas.length; x++)
    {
      Carta carta = cartas[x];

      if (carta.getNome() != "Joker" && carta.getNome() != "JokerMais4")
      {
        Carta removida = this.baralho.getCartasBaralho().remove(x);
        cartasUsadas.push(removida);
        break;
      }
    }
  }

  public void comecarJogo()
  {
    Carta carta;
    Jogador jogadorVez;
    bool possuiCartaValida;
    int totalCartasJogador;
    Carta cartaTopoPilha;

    Decoracao.mensagemRetangulo("Comeco do Jogo");

    while (!jogoEncerrado)
    {
      bool sentidoRotacao = jogadores.getSentidoRotacao();
      jogadorVez = jogadores.getJogadorVez();
      totalCartasJogador = jogadorVez.getMaoCartas().length;
      cartaTopoPilha = cartasUsadas.getLast();
      possuiCartaValida = false;

      if (jogadorVez.isUno())
      {
        writeln();
        write("\x1b[32m");
        writeln("UNO!");
        write("\x1b[0m");
        writeln();
      }

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

        writeln();
        writeln(jogadorVez.toString(), "Nao possui cartas valida, indo comprar...");

        try
        {
          regrasUno.jogarCarta(cartaComprada);
          writeln();
          writeln(jogadorVez.getNome() ~ " comprou e jogou ", cartaComprada.toString());
          cartasUsadas.push(cartaComprada);
        }
        catch (JogadaInvalidaException)
        {
          writeln();
          writeln(jogadorVez.toString(), " Nao possui carta valida, mesmo comprando, indo pro proximo....");
          jogadorVez.adicionarCarta(cartaComprada);
          jogadores.mudarVezJogador();
          writeln();
        }

        Decoracao.aMimir(2);
        Decoracao.limparTela();

        continue;
      }

      writeln();
      writeln("-".replicate(50));
      Decoracao.printSimetrico("Ultima carta jogada:", cartaTopoPilha.toString());
      Decoracao.printSimetrico("Vez do Jogador:", jogadorVez.toString());
      Decoracao.printSimetrico("Sentido Rotacao:", sentidoRotacao ? "Invertido" : "Normal");
      writeln("-".replicate(50));
      writeln();

      Decoracao.aMimir(1);

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

      if (baralho.getCartasBaralho().length == 0)
      {
        reporCartas();
      }

    }
  }

  public void reporCartas()
  {
    auto cartas = baralho.getCartasBaralho();

    while (!cartasUsadas.isEmpty())
    {
      cartas.add(
        cartasUsadas.pop()
      );
    }

    cartas.shuffle();
  }

  public void testarCartaValida(Carta carta)
  {
    Carta cartaTopoPilha = this.getCartasUsadas().getLast();

    string nomeCartaTopoPilha = cartaTopoPilha.getNome();
    string corCartaTopoPilha = cartaTopoPilha.getCor();

    string nomeCarta = carta.getNome();
    string corCarta = carta.getCor();

    if (
      (nomeCartaTopoPilha == "Joker" || nomeCartaTopoPilha == "JokerMais4") &&
      (nomeCarta == "Joker" || nomeCarta == "JokerMais4")
      )
    {
      throw new JogadaInvalidaException("Não é possiel jogar 2 jokes seguidos");
    }

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
      throw new JogadaInvalidaException("Jogada Invalida!!!");
    }
  }

  public void mostrarVencedor()
  {
    writeln();
    write("\x1b[34m");
    writeln(vencedor, " Venceu o jogo!!!");
    write("\x1b[0m");

    Decoracao.aMimir(2);

    writeln();
    writeln();

    writeln(".........        .. .......         ");
    writeln(
      "                                                                 ....:-----:..........------..         ");
    writeln(
      "                                                                .:----::::----:..:-----::::--..        ");
    writeln(
      "                                                              ..:--::::::::::------::::::::--:.        ");
    writeln(
      "                                                              ..:-:::::::::::::--:::::::::::-:.        ");
    writeln(
      "                                             .......          ..:-:::::::::::::::::::::::::--..        ");
    writeln(
      "                                        ......:---:.....      ..:--::::::--:::::::::::---::--..        ");
    writeln(
      "                                       ......:-:::-:....      ...---::::--::::::-::-::--::--...        ");
    writeln(
      "                                      ..:--::::::::----:..      ..---::::::--::------::::--...         ");
    writeln(
      " ...                                  ..:-::::::::::::-:..       ...---:::::--------:::---..  .        ");
    writeln(
      " ..                                   ...:-:::---:::::-:..         ..:--::::::::::::::--:...           ");
    writeln(
      "                 ..                     .:-:--=====-::-:.            ..:---:::::::::---:..             ");
    writeln(
      "                                        ..:-==----==-:::.            ....:--:::::::--:....             ");
    writeln(
      "                                        ..:-::::::-=-....              ....:--------:...               ");
    writeln(
      "                             .=##=..   ..-=-:::::-::=-..                    ....:---:..                ");
    writeln(
      "                        ...=%@@@@@@@=...-=-:-:::::::-=-....-+**+-..            ...:-:..              ");
    writeln(
      "                        .-@@@@#:=@@@@@===-::::::::-::--=@@@@@@@@@@@#..               .:-:.             ");
    writeln(
      "                      .-@@@@=... ..#@%==----------::::-=#@@=:.  :%@@@..               .:-:.            ");
    writeln(
      "                    ..*@@@+..     ..:==--::::::::::::--==.       :#@@@..               .::..           ");
    writeln(
      "                    :%@@@-.         ..-==-::::::::----==-.        -@@@=.               ..-:.           ");
    writeln(
      "                   .=@@%:.           .---::-=========::...        .+@@%:                .-:.           ");
    writeln(
      "             :#@%-.......           .:--..:--:..---..              :%@@= .......        .-:.           ");
    writeln(
      "             :#@@@@-                .--:..--:..:--:.               ..==.:+#@@@%:.      .::.            ");
    writeln(
      "            .==-==-.                .:-:..---...-:..                   .%@@@@@%-.     .:-:.            ");
    writeln(
      "            +@@@@%-                      ... .                         .........     .:-:.             ");
    writeln(
      "            .=%@@@=                                                    .-@@@@@@=.   ..-:.              ");
    writeln(
      "             .....                                                     .:%@@#+=..  ..--..              ");
    writeln(
      "               ..............                                                    ..:-:..               ");
    writeln(
      "               ..:::::..*@@@+    ..--:..:==-..       ...  .-=-..      ...      ..:--:.                 ");
    writeln(
      "               ..:::::..+@@@=  ...%@@@+%@@@@@+:..=%%=.....#@@@%.     .......  ..:-:..                  ");
    writeln(
      "               ...%@@#.       .....%@@@@@%#@@@@@@@@@.::...#@@.     ::::::...:-:...                   ");
    writeln(
      "                 .=@@@@-..   ..::....:@@@-:--@@@@#*:.:::::.....     .:---:..:-:..                      ");
    writeln(
      "                  .:#@@@%-... ....   :@@@*:::#@@@..::::::::.      ..-%@@%:--:..                        ");
    writeln(
      "                   ..:@@@@@@%=--:.   .=@@*:::%@@+..::::.....    .-+@@@@%--:...                         ");
    writeln(
      "            ..      .#@@@@@@@@@@@*.   =@@@=::%@@=.........:+%@@@@@@@@@=--:.                            ");
    writeln(
      "                    .%@@%. .......    .@@@#:=@@@=...:::..:@@@@@@%*#@@%-:. .                            ");
    writeln(
      "                    .:@@@%-.  ....    .-@@%-#@@%...:::............:@@+-..                              ");
    writeln(
      "                     ..%@@@+...::::..  .@@@@@@@-   ....      ..:+%@@@-:.                               ");
    writeln(
      "                     ..#@@@#.::::::..  .:#@@@@=.             .#@@@@@=-:.                               ");
    writeln(
      "                     .*@@@=..:::::...   ...::...            .:@@@=...-:.                               ");
    writeln(
      "                  .:#@@@@+..::::..    .:....                .+@@@:  .:-..   ..:---:.                   ");
    writeln(
      "                 .=@@@@@#.........    .---:.                :@@@+    .:-:.. .-:..:-.                   ");

    writeln();
  }

  public void main()
  {
    //this.telaInicial();

    this.baralho.gerarCartas();
    this.baralho.embaralharCartas();

    this.gerarJogadores();
    this.mostrarJogadores();
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
