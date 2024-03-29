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

  public string[] cartasNumeracao;
  public string[] cartaEspecial;
  private string[] corCarta;
  private string[] cartaSentido;
  private string[] jokers;

  private Carta[] cartas;
  private Jogador[] jogadores;
  private Carta[] cartasUsadas;
  private string sentidoRotacao;

  public this()
  {
    this.cartasNumeracao = [
      "Zero", "Um", "Dois", "Tres", "Quatro", "Cinco", "Seis", "Sete", "Oito",
      "Nove"
    ];
    this.cartaEspecial = [
      "Bloqueio", "Inverter", "Mais2"
    ];
    this.jokers = ["Joker", "JokerMais4"];
    this.corCarta = ["vermelho", "azul", "verde", "amarelo"];
    this.cartaSentido = ["esquerda", "direita"];
  }

  public void gerarCartas()
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

  public Carta[] getCartas()
  {
    return cartas;
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

  public void embaralharCartas() {
     randomShuffle(cartas);
  }

  public void main() {
     this.gerarCartas();
     this.embaralharCartas();
  }

}
