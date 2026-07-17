REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cIdade := ""
    LOCAL cDependentes := ""

    LOCAL nIdade := 0
    LOCAL nDependentes := 0

    LOCAL nPlano := 0
    LOCAL nAdicional := 0
    LOCAL nTotal := 0

    HB_CDPSELECT("PT850")

    ? "====================================="
    ? "      CALCULO DO PLANO DE SAUDE"
    ? "====================================="
    ?

    ACCEPT "Digite a idade: " TO cIdade
    nIdade := Val(cIdade)

    ACCEPT "Quantidade de dependentes: " TO cDependentes
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

    nAdicional := nDependentes * 90
    nTotal := nPlano + nAdicional

    ?
    ? "========== RESULTADO =========="
    ? "Idade...............:", nIdade
    ? "Dependentes.........:", nDependentes
    ? "Valor do plano......: R$", nPlano
    ? "Adicional...........: R$", nAdicional
    ? "Total a pagar.......: R$", nTotal

RETURN NIL