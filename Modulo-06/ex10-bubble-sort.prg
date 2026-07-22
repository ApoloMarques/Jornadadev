REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL aNumeros := {}
    LOCAL cNumero := ""
    LOCAL nI

    HB_CDPSELECT("PT850")

    CLS
    ? "==============================="
    ? "       BUBBLE SORT"
    ? "==============================="
    ?

    FOR nI := 1 TO 10

        ACCEPT "Digite o " + LTrim(Str(nI)) + " numero: " TO cNumero
        AAdd(aNumeros, Val(cNumero))

    NEXT

    BubbleSort(@aNumeros)

    ?

    ? "Numeros em ordem crescente:"

    FOR nI := 1 TO Len(aNumeros)
        ? aNumeros[nI]
    NEXT

RETURN NIL


FUNCTION BubbleSort(aVetor)

    LOCAL nI
    LOCAL nJ
    LOCAL nAux

    FOR nI := 1 TO Len(aVetor) - 1

        FOR nJ := 1 TO Len(aVetor) - nI

            IF aVetor[nJ] > aVetor[nJ + 1]

                nAux := aVetor[nJ]
                aVetor[nJ] := aVetor[nJ + 1]
                aVetor[nJ + 1] := nAux

            ENDIF

        NEXT

    NEXT

RETURN NIL