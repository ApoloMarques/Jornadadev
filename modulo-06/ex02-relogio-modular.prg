REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cHora
    LOCAL nInicio := Seconds()

    HB_CDPSELECT("PT850")

    DO WHILE Seconds() - nInicio < 30

        cHora := ObterHora()
        cHora := FormatarHora(cHora)

        ExibirHora(cHora)

        Inkey(1)

    ENDDO

RETURN NIL


FUNCTION ObterHora()

RETURN Time()


FUNCTION FormatarHora(cHora)

RETURN cHora


FUNCTION ExibirHora(cHora)

    CLS
    ? "==========================="
    ? "     RELOGIO DIGITAL"
    ? "==========================="
    ?
    ? "Hora atual:", cHora

RETURN NIL