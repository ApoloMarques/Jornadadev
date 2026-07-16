FUNCTION Main()

    LOCAL nNumero := 50
    LOCAL cTexto := ""
    //LOCAL dData := DATE()
    LOCAL dData := DATE()

    SET DATE FORMAT TO "DD/MM/YYYY"

    QOut("Texto: " + cTexto)
    QOut("Numero: " + Alltrim(str(nNumero)))
    QOut("Data: " + DToC(dData))

RETURN NIL
