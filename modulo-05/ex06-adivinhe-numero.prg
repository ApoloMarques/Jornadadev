REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cPalpite
    LOCAL nPalpite
    LOCAL nNumero
    LOCAL nI

    HB_CDPSELECT("PT850")

    nNumero := HB_RandomInt(1,100)

    FOR nI := 1 TO 7

        ACCEPT "Digite um numero: " TO cPalpite
        nPalpite := Val(cPalpite)

        IF nPalpite == nNumero
            ? "Parabens! Voce acertou!"
            EXIT
        ENDIF

        IF nPalpite < nNumero
            ? "O numero secreto e maior."
        ELSE
            ? "O numero secreto e menor."
        ENDIF

    NEXT

    IF nPalpite <> nNumero
        ?
        ? "Suas tentativas acabaram."
        ? "Numero sorteado:", nNumero
    ENDIF

RETURN NIL