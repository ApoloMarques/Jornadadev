REQUEST HB_CODEPAGE_PT850

FUNCTION Main()
    LOCAL nA := 5, nB := 5
    LOCAL cLong := "Harbour", cShort := "Harb"

    HB_CDPSELECT("PT850")

    QOut("Exemplo: '=' (atribui‡Æo) x '==' (compara‡Æo)")

    QOut("\n1) Atribui‡Æo com '=':")
    QOut("Antes: nA = " + AllTrim(Str(nA)))
    nA = 10
    QOut("Depois de 'nA = 10': nA = " + AllTrim(Str(nA)))

    QOut("\n2) Compara‡Æo com '==':")
    QOut("nA == nB ? " + If(nA == nB, "Verdadeiro", "Falso"))

    QOut("\n3) Compara‡Æo de strings:")
    QOut("cLong = '" + cLong + "', cShort = '" + cShort + "'")
    QOut("cLong == cShort ? " + If(cLong == cShort, "Verdadeiro", "Falso"))

    QOut("\nObserva‡Æo: '=' atribui um valor; '==' compara igualdade. Use '==' para comparar.")

RETURN NIL
