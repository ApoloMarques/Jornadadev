FUNCTION Main()

    LOCAL n1, n2, n3, n4, nMedia

    INPUT "Nota 1 (peso 1): " TO n1
    INPUT "Nota 2 (peso 2): " TO n2
    INPUT "Nota 3 (peso 3): " TO n3
    INPUT "Nota 4 (peso 4): " TO n4

    nMedia := (n1 + n2*2 + n3*3 + n4*4) / 10

    QOut("Média: " + Alltrim(Str(nMedia, 10, 2)))
    QOut(If(nMedia >= 7, "APROVADO", "REPROVADO"))

RETURN NIL
