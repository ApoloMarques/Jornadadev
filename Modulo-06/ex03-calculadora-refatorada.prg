REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nA, nB, nResultado
    LOCAL cOperacao

    HB_CDPSELECT("PT850")

    LerValores(@nA, @nB, @cOperacao)

    IF Calcular(nA, nB, cOperacao, @nResultado)
        MostrarResultado(nResultado)
    ELSE
        ? "Erro: operacao invalida ou divisao por zero."
    ENDIF

RETURN NIL


FUNCTION LerValores(nA, nB, cOperacao)

    LOCAL cValor

    CLS
    ? "============================="
    ? "      CALCULADORA DEV"
    ? "============================="
    ?

    ACCEPT "Primeiro valor: " TO cValor
    nA := Val(cValor)

    ACCEPT "Operacao (+,-,*,/,^,R): " TO cOperacao
    cOperacao := Upper(AllTrim(cOperacao))

    IF cOperacao <> "R"
        ACCEPT "Segundo valor: " TO cValor
        nB := Val(cValor)
    ENDIF

RETURN NIL


FUNCTION Calcular(nA, nB, cOperacao, nResultado)

    DO CASE

    CASE cOperacao == "+"
        nResultado := nA + nB

    CASE cOperacao == "-"
        nResultado := nA - nB

    CASE cOperacao == "*"
        nResultado := nA * nB

    CASE cOperacao == "/"

        IF nB == 0
            RETURN .F.
        ENDIF

        nResultado := nA / nB

    CASE cOperacao == "^"
        nResultado := nA ^ nB

    CASE cOperacao == "R"
        nResultado := Sqrt(nA)

    OTHERWISE
        RETURN .F.

    ENDCASE

RETURN .T.


FUNCTION MostrarResultado(nResultado)

    ?
    ? "Resultado:", nResultado

RETURN NIL