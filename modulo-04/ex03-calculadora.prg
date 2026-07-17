REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cValor1 := ""
    LOCAL cValor2 := ""
    LOCAL cOperacao := ""
    LOCAL nValor1 := 0
    LOCAL nValor2 := 0
    LOCAL nResultado := 0

    HB_CDPSELECT("PT850")

    ? "=================================="
    ? "        CALCULADORA DEV"
    ? "=================================="
    ?
    ? "Operacoes disponiveis:"
    ? "+  Soma"
    ? "-  Subtracao"
    ? "*  Multiplicacao"
    ? "/  Divisao"
    ? "^  Potencia"
    ? "R  Raiz quadrada"
    ?

    ACCEPT "Digite o primeiro valor: " TO cValor1
    nValor1 := Val(cValor1)

    ACCEPT "Digite a operacao: " TO cOperacao

    IF Upper(cOperacao) <> "R"
        ACCEPT "Digite o segundo valor: " TO cValor2
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
            ?
            ? "Erro: divisao por zero."
            RETURN NIL
        ENDIF

        nResultado := nValor1 / nValor2

    CASE cOperacao == "^"
        nResultado := nValor1 ^ nValor2

    CASE Upper(cOperacao) == "R"
        nResultado := Sqrt(nValor1)

    OTHERWISE
        ?
        ? "Operacao invalida."
        RETURN NIL

    ENDCASE

    ?
    ? "Resultado:", nResultado

RETURN NIL