REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cSalario := ""
    LOCAL nSalario := 0
    LOCAL nPercentual := 0
    LOCAL nNovoSalario := 0

    HB_CDPSELECT("PT850")

    ? "=================================="
    ? "    REAJUSTE SALARIAL"
    ? "=================================="

    ACCEPT "Digite o salario atual: " TO cSalario

    nSalario := Val(cSalario)

    IF nSalario < 1000
        nPercentual := 15

    ELSEIF nSalario <= 2000
        nPercentual := 12

    ELSEIF nSalario <= 4000
        nPercentual := 8

    ELSE
        nPercentual := 5

    ENDIF

    nNovoSalario := nSalario + ( nSalario * nPercentual / 100 )

    ?
    ? "Salario atual....: R$", nSalario
    ? "Reajuste.........:", nPercentual, "%"
    ? "Novo salario.....: R$", nNovoSalario

RETURN NIL