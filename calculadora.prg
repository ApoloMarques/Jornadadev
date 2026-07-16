FUNCTION Main()

    LOCAL nA, nB

    ACCEPT "Digite o primeiro numero: " TO nA
    nA := Val(nA)

    ACCEPT "Digite o segundo numero: " TO nB
    nB := Val(nB)

    QOut("Soma        : " + Alltrim(Str(nA + nB, 10, 2)))
    QOut("Subtracao   : " + Alltrim(Str(nA - nB, 10, 2)))
    QOut("Produto     : " + Alltrim(Str(nA * nB, 10, 2)))

    IF nB <> 0
        QOut("Divisao     : " + Alltrim(Str(nA / nB, 10, 2)))
    ELSE
        QOut("Divisao     : nao e possivel dividir por zero.")
    ENDIF

RETURN NIL
