REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cValor
    LOCAL nValor

    HB_CDPSELECT("PT850")

    WHILE .T.

        ACCEPT "Digite um valor: " TO cValor
        nValor := Val(cValor)

        IF nValor <= 0
            EXIT
        ENDIF

        ? "Dobro:", nValor * 2
        ?

    ENDDO

    ? "Programa encerrado."

RETURN NIL