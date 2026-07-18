REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cIdade, cDependentes
    LOCAL nIdade, nDependentes, nPlano

    HB_CDPSELECT("PT850")

    ACCEPT "Digite a idade: " TO cIdade
    ACCEPT "Quantidade de dependentes: " TO cDependentes

    nIdade := Val(cIdade)
    nDependentes := Val(cDependentes)

    IF nIdade <= 25
        nPlano := 180
    ELSEIF nIdade <= 40
        nPlano := 260
    ELSEIF nIdade <= 60
        nPlano := 380
    ELSE
        nPlano := 520
    ENDIF

    ? "Total a pagar: R$", nPlano + ( nDependentes * 90 )

RETURN NIL