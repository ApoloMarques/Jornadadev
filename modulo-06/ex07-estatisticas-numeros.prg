REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL aNumeros := {}
    LOCAL cNumero := ""
    LOCAL nNumero
    LOCAL nI
    LOCAL nSoma := 0

    HB_CDPSELECT("PT850")

    CLS
    ? "=================================="
    ? " ESTATISTICAS DE 10 NUMEROS"
    ? "=================================="
    ?

    FOR nI := 1 TO 10

        ACCEPT "Digite o " + LTrim(Str(nI)) + "º numero: " TO cNumero

        nNumero := Val(cNumero)

        AAdd(aNumeros, nNumero)
        nSoma += nNumero

    NEXT

    ASort(aNumeros)

    ?

    ? "Numeros em ordem crescente:"

    FOR nI := 1 TO Len(aNumeros)
        ? aNumeros[nI]
    NEXT

    ?

    ? "Menor numero :", aNumeros[1]
    ? "Maior numero :", aNumeros[Len(aNumeros)]
    ? "Soma.........:", nSoma
    ? "Media........:", nSoma / Len(aNumeros)

RETURN NIL