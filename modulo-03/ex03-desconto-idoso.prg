REQUEST HB_CODEPAGE_PT850

FUNCTION Main()
    LOCAL cNome := "", cDataNasc := "", dNasc := CTOD("01/01/1900"), nPreco := 0.0, nIdade := 0, nDesconto := 0.0

    HB_CDPSELECT("PT850")
    SET DATE BRITISH

    DO WHILE Empty(AllTrim(cNome))
        ACCEPT "Nome do cliente: " TO cNome
    ENDDO

    DO WHILE Empty(AllTrim(cDataNasc)) .OR. Empty(dNasc) .OR. dNasc > Date()
        ACCEPT "Data de nascimento (DD/MM/YYYY): " TO cDataNasc
        dNasc := CTOD(cDataNasc)
    ENDDO

    DO WHILE nPreco <= 0
        INPUT "Pre‡o do produto: " TO nPreco
    ENDDO

    nIdade := Year(Date()) - Year(dNasc)
    nIdade := nIdade - IIF(Month(Date()) < Month(dNasc) .OR. (Month(Date()) == Month(dNasc) .AND. Day(Date()) < Day(dNasc)), 1, 0)
    nDesconto := IIF(nIdade > 60, nPreco * 0.125, 0.0)

    QOut("Resumo do pedido:")
    QOut("Cliente: " + cNome)
    QOut("Idade: " + AllTrim(Str(nIdade)))
    QOut("Pre‡o: R$ " + AllTrim(Str(nPreco, 10, 2)))
    QOut("Desconto: R$ " + AllTrim(Str(nDesconto, 10, 2)))
    QOut("Total: R$ " + AllTrim(Str(nPreco - nDesconto, 10, 2)))

RETURN NIL
