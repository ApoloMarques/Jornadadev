FUNCTION Main()

    LOCAL cNome := "João", nIdade := 30, dData := Date(), lAtivo := .T.

    QOut("Nome: " + cNome)
    QOut("Idade: " + Alltrim(Str(nIdade)))
    QOut("Data: " + DToC(dData))
    QOut("Ativo: " + If(lAtivo, "Sim", "Não"))

RETURN NIL
