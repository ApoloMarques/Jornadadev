FUNCTION Main()

    LOCAL dNasc, nPreco, nIdade

    ACCEPT "Data nascimento (DD/MM/YYYY): " TO dNasc
    INPUT "Preço: " TO nPreco

    dNasc := CtoD(dNasc)
    nIdade := Year(Date()) - Year(dNasc)

    IF Month(Date()) < Month(dNasc) .OR. (Month(Date()) = Month(dNasc) .AND. Day(Date()) < Day(dNasc))
        nIdade := nIdade - 1
    ENDIF

    QOut("Idade: " + Alltrim(Str(nIdade)))
    QOut("Preço: R$ " + Alltrim(Str(nPreco, 10, 2)))

    IF nIdade >= 60
        QOut("Desconto: R$ " + Alltrim(Str(nPreco * 0.125, 10, 2)))
        QOut("Total: R$ " + Alltrim(Str(nPreco * 0.875, 10, 2)))
    ELSE
        QOut("Sem desconto")
    ENDIF

RETURN NIL
