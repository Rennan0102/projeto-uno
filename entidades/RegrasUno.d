module entidades.RegrasUno;

import entidades.Uno;
import std.stdio;

export class RegrasUno
{

    private Uno uno;

    public this()
    {
        this.uno = null;
    }

    public void setUno(Uno uno)
    {
        this.uno = uno;
    }

    public void carta_inverter()
    {
        bool vez = uno.getSentidoInvertido();

        uno.setSentidoInvertido(!vez);
    }

    void jogarCarta(string nomeCarta)
    {
        switch (nomeCarta)
        {
        case "Zero":
            carta_Zero();
            break;
        case "Um":
            carta_Um();
            break;
        case "Bloqueio":
            carta_Bloqueio();
            break;
        case "Inverter":
            carta_Inverter();
            break;
        case "Mais2":
            carta_Mais2();
            break;
        case "Joker":
            carta_Joker();
            break;
        case "JokerMais4":
            carta_JokerMais4();
            break;
        default:
            writeln("Carta não reconhecida.");
        }
    }

        // Métodos para cada carta
        void carta_Zero()
        {
            writeln("Jogou a carta Zero.");
        }

        void carta_Um()
        {
            writeln("Jogou a carta Um.");
        }

        void carta_Bloqueio()
        {
            writeln("Jogou a carta Bloqueio.");
        }

        void carta_Inverter()
        {
            writeln("Jogou a carta Inverter.");
        }

        void carta_Mais2()
        {
            writeln("Jogou a carta Mais 2.");
        }

        void carta_Joker()
        {
            writeln("Jogou a carta Joker.");
        }

        void carta_JokerMais4()
        {
            writeln("Jogou a carta Joker +4.");
        }

    }
