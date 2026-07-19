REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cValor
    LOCAL nValor
    LOCAL nTotal := 0
    LOCAL nQtd := 0

    HB_CDPSELECT("PT850")

    WHILE .T.

        ACCEPT "Digite um valor (0 encerra): " TO cValor
        nValor := Val(cValor)

        IF nValor == 0
            EXIT
        ENDIF

        nTotal += nValor
        nQtd++

    ENDDO

    ?

    ? "Soma........:", nTotal
    ? "Quantidade..:", nQtd

RETURN NIL