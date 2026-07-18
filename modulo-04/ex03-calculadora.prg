REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cValor1, cValor2, cOperacao
    LOCAL nValor1, nValor2, nResultado

    HB_CDPSELECT("PT850")

    ACCEPT "Primeiro valor: " TO cValor1
    ACCEPT "Operacao (+,-,*,/,^,R): " TO cOperacao

    nValor1 := Val(cValor1)

    IF Upper(cOperacao) <> "R"
        ACCEPT "Segundo valor: " TO cValor2
        nValor2 := Val(cValor2)
    ENDIF

    DO CASE
    CASE cOperacao == "+"
        nResultado := nValor1 + nValor2

    CASE cOperacao == "-"
        nResultado := nValor1 - nValor2

    CASE cOperacao == "*"
        nResultado := nValor1 * nValor2

    CASE cOperacao == "/"
        IF nValor2 == 0
            ? "Erro: divisao por zero."
            RETURN NIL
        ENDIF
        nResultado := nValor1 / nValor2

    CASE cOperacao == "^"
        nResultado := nValor1 ^ nValor2

    CASE Upper(cOperacao) == "R"
        nResultado := Sqrt(nValor1)

    OTHERWISE
        ? "Operacao invalida."
        RETURN NIL
    ENDCASE

    ? "Resultado:", nResultado

RETURN NIL