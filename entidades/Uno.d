module entidades.Uno;

import std.stdio;
import std.conv;
import std.random;
import std.range;

import entidades.Carta;
import entidades.Jogador;

export class Uno {
  public static numeroCartaEspecial = 8;
  public static numeroCartaJoker = 4;

  public static string[] cartasNumeracao;
  public static string[] cartaEspecial;
  private static string[] corCarta;
  private static string[] cartaSentido;
  private static string[] jokers;

  private static Carta[] cartas;
  private static Jogador[] jogadores;
  private static Carta[] cartasUsadas;
  private static string sentidoRotacao;

  public static this()
  {
    cartasNumeracao = [
      "Zero", "Um", "Dois", "Tres", "Quatro", "Cinco", "Seis", "Sete", "Oito",
      "Nove"
    ];
    cartaEspecial = [
      "Bloqueio", "Inverter", "Mais2"
    ];
    jokers = ["Joker", "JokerMais4"];
    corCarta = ["vermelho", "azul", "verde", "amarelo"];
    cartaSentido = ["esquerda", "direita"];
  }

  public static void gerarCartas()
  {

    // Cartas numeradas de 0 a 9 para cada cor
    foreach (string cor; corCarta)
    {
      foreach (string numero; cartasNumeracao)
      {
        if (numero == "Zero")
        {
          cartas ~= new CartaComum(numero, cor);
        }
        else
        {
          cartas ~= new CartaComum(numero, cor);
          cartas ~= new CartaComum(numero, cor);

        }
      }
    }

    // Cartas especiais
    foreach (string cor; corCarta)
    {
      foreach (string especial; cartaEspecial)
      {
        cartas ~= new CartaComum(especial, cor);
        cartas ~= new CartaComum(especial, cor);
      }
    }

    // Cartas coringas

    foreach (string joker; this.jokers)
    {
      foreach (_; 0 .. 4)
      {
        cartas ~= new CartaJoker(joker);
      }
    }
  }

  public static Carta[] getCartas(){
    return cartas;
  }

  public static void telaInicial()
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


  public static void main() {
     gerarCartas();
     embaralharCartas();
  }

  public static void embaralharCartas() {
        randomShuffle(cartas);
    }



}
