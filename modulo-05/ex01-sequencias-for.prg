REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nI

    HB_CDPSELECT("PT850")

    // Item A
    CLS
    ? "Item A - Numeros de 1 a 100"
    ?

    FOR nI := 1 TO 100
        ? nI
    NEXT

    ?
    ? "Pressione qualquer tecla..."
    Inkey(0)

    // Item B
    CLS
    ? "Item B - Numeros de -50 a 50"
    ?

    FOR nI := -50 TO 50
        ? nI
    NEXT

    ?
    ? "Pressione qualquer tecla..."
    Inkey(0)

    // Item C
    CLS
    ? "Item C - Numeros de 80 a 5"
    ?

    FOR nI := 80 TO 5 STEP -1
        ? nI
    NEXT

    ?
    ? "Fim do exercicio."
    Inkey(0)

RETURN NIL