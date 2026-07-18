REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cSalario
    LOCAL nSalario, nPercentual

    HB_CDPSELECT("PT850")

    ACCEPT "Digite o salario: " TO cSalario
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

    ? "Novo salario: R$", nSalario + ( nSalario * nPercentual / 100 )

RETURN NIL