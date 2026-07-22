REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL aCarrinho := {}
    LOCAL aProduto
    LOCAL cNome := ""
    LOCAL cPreco := ""
    LOCAL cOpcao := "S"
    LOCAL nI
    LOCAL nTotal := 0

    HB_CDPSELECT("PT850")

    DO WHILE Upper(cOpcao) == "S"

        CLS
        ? "==============================="
        ? "    MINI CARRINHO DE COMPRAS"
        ? "==============================="
        ?

        ACCEPT "Produto: " TO cNome
        ACCEPT "Preco: " TO cPreco

        aProduto := { AllTrim(cNome), Val(cPreco) }

        AAdd(aCarrinho, aProduto)

        ACCEPT "Adicionar outro? (S/N): " TO cOpcao
        cOpcao := Upper(AllTrim(cOpcao))

    ENDDO

    CLS
    ? "========== CARRINHO =========="

    FOR nI := 1 TO Len(aCarrinho)

        ? aCarrinho[nI][1], "- R$", aCarrinho[nI][2]

        nTotal += aCarrinho[nI][2]

    NEXT

    ?

    ? "TOTAL: R$", nTotal

RETURN NIL