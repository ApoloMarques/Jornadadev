REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cJogador
    LOCAL cCPU
    LOCAL cOpcao := "S"

    HB_CDPSELECT("PT850")

    DO WHILE Upper(cOpcao) == "S"

        CLS
        ? "=========================="
        ? "        JOKENPO"
        ? "=========================="
        ?

        cJogador := ValidarJogada()
        cCPU := SortearJogadaCPU()

        ?

        ? "Voce........:", cJogador
        ? "Computador..:", cCPU
        ?

        ? DefinirVencedor(cJogador, cCPU)

        ?
        ACCEPT "Jogar novamente? (S/N): " TO cOpcao
        cOpcao := Upper(AllTrim(cOpcao))

    ENDDO

RETURN NIL


FUNCTION ValidarJogada()

    LOCAL cJogada := ""

    DO WHILE .T.

        ACCEPT "Digite Pedra, Papel ou Tesoura: " TO cJogada

        cJogada := Upper(AllTrim(cJogada))

        IF cJogada == "PEDRA" .OR. ;
           cJogada == "PAPEL" .OR. ;
           cJogada == "TESOURA"
            EXIT
        ENDIF

        ? "Jogada invalida."

    ENDDO

RETURN cJogada


FUNCTION SortearJogadaCPU()

    LOCAL aJogadas := {"PEDRA","PAPEL","TESOURA"}

RETURN aJogadas[ HB_RandomInt(1,3) ]


FUNCTION DefinirVencedor(cJogador, cCPU)

    IF cJogador == cCPU
        RETURN "Empate!"

    ENDIF

    IF ( cJogador == "PEDRA"   .AND. cCPU == "TESOURA" ) .OR. ;
       ( cJogador == "PAPEL"   .AND. cCPU == "PEDRA" )   .OR. ;
       ( cJogador == "TESOURA" .AND. cCPU == "PAPEL" )

        RETURN "Voce venceu!"

    ENDIF

RETURN "Computador venceu!"