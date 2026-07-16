FUNCTION Main()

    LOCAL nA := 5, nB := 5

    QOut("= (atribuição): nA = 10 → nA recebe 10")
    nA = 10
    QOut("nA agora vale: " + Alltrim(Str(nA)))
    QOut("")
    QOut("== (comparação): nA == nB")
    QOut("Resultado: " + If(nA == nB, "Verdadeiro", "Falso"))
    QOut("(nA=" + Alltrim(Str(nA)) + ", nB=" + Alltrim(Str(nB)) + ")")

RETURN NIL
