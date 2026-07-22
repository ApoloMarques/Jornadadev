REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL aDias := { ;
        "Domingo", ;
        "Segunda-feira", ;
        "Terca-feira", ;
        "Quarta-feira", ;
        "Quinta-feira", ;
        "Sexta-feira", ;
        "Sabado" }

    LOCAL cNumero := ""
    LOCAL nDia

    HB_CDPSELECT("PT850")

    CLS
    ? "=============================="
    ? "     DIAS DA SEMANA"
    ? "=============================="
    ?

    ACCEPT "Digite um numero (1 a 7): " TO cNumero

    nDia := Val(cNumero)

    IF nDia >= 1 .AND. nDia <= Len(aDias)

        ?
        ? "Dia:", aDias[nDia]

    ELSE

        ?
        ? "Numero invalido."

    ENDIF

RETURN NIL