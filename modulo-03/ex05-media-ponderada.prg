REQUEST HB_CODEPAGE_PT850

FUNCTION Main()
    LOCAL n1 := 0.0, n2 := 0.0, n3 := 0.0, n4 := 0.0, nMedia := 0.0

    HB_CDPSELECT("PT850")

    INPUT "Nota 1 (peso 1): " TO n1
    INPUT "Nota 2 (peso 2): " TO n2
    INPUT "Nota 3 (peso 3): " TO n3
    INPUT "Nota 4 (peso 4): " TO n4

    nMedia := (n1*1 + n2*2 + n3*3 + n4*4) / 10

    QOut("M‚dia ponderada: " + AllTrim(Str(nMedia, 10, 2)))
    QOut(If(nMedia >= 7, "APROVADO", "REPROVADO"))

RETURN NIL
