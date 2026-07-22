REQUEST HB_CODEPAGE_PT850

SET PROCEDURE TO estoque_lib.prg

FUNCTION Main()

    LOCAL aProdutos := {}
    LOCAL cOpcao := ""

    HB_CDPSELECT("PT850")

    DO WHILE cOpcao <> "0"

        cOpcao := MostrarMenu()

        DO CASE

        CASE cOpcao == "1"
            CadastrarProduto(@aProdutos)

        CASE cOpcao == "2"
            ListarProdutos(aProdutos)

        CASE cOpcao == "3"
            EntradaEstoque(@aProdutos)

        CASE cOpcao == "4"
            SaidaEstoque(@aProdutos)

        CASE cOpcao == "5"
            BuscarProduto(aProdutos)

        CASE cOpcao == "6"
            Relatorio(aProdutos)

        CASE cOpcao == "0"
            ? "Programa encerrado."

        OTHERWISE
            ? "Opcao invalida."

        ENDCASE

        IF cOpcao <> "0"
            ?
            ? "Pressione qualquer tecla..."
            Inkey(0)
        ENDIF

    ENDDO

RETURN NIL