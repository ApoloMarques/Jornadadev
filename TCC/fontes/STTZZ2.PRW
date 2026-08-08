#include "protheus.ch"

/*/{Protheus.doc} STTZZ2
Consulta geral das ocorrencias de fornecedores.

Apresenta o cadastro da ZZ2 em mBrowse com legenda
de nao conformidade comparada a tolerancia da ZZ1.

@type     function
@author   Jose Apolo Marques Nascimento
@since    04/08/2026
/*/
USER FUNCTION STTZZ2()

    BrowseZZ2("")

RETURN NIL

/*/{Protheus.doc} STTZZ2FLT
Consulta das ocorrencias filtradas pelo controle ZZ1.

@param cCodigoZZ1, character, Codigo do controle de fornecimento
@type  function
@author Jose Apolo Marques Nascimento
@since 04/08/2026
/*/
USER FUNCTION STTZZ2FLT(cCodigoZZ1)

    DEFAULT cCodigoZZ1 := ""

    BrowseZZ2(AllTrim(cCodigoZZ1))

RETURN NIL

/*/{Protheus.doc} BrowseZZ2
Monta o browse geral ou filtrado da tabela ZZ2.

@param cCodigoZZ1, character, Codigo do controle para filtro
@type  function
/*/
STATIC FUNCTION BrowseZZ2(cCodigoZZ1)

    LOCAL aArea       := GetArea()
    LOCAL bError      := ErrorBlock({|oError| Break(oError)})
    LOCAL oError
    LOCAL cFiltro     := ""
    LOCAL aIndexZZ2   := {}
    LOCAL lFiltrado   := .F.
    LOCAL aCores      := {;
        {"U_PERCNAOCONFORME(ZZ2->ZZ2_QTDOK," + ;
         "ZZ2->ZZ2_QTDNOK) > " + ;
         "POSICIONE('ZZ1',1,XFILIAL('ZZ1')+" + ;
         "ZZ2->ZZ2_CONFOR,'ZZ1_TOLERA')", "BR_VERMELHO"},;
        {".T.", "BR_VERDE"};
    }

    PRIVATE cCadastro := "Ocorrencias do Fornecedor"
    PRIVATE aRotina   := {;
        {"Pesquisar" , "AxPesqui", 0, 1},;
        {"Visualizar", "AxVisual", 0, 2},;
        {"Incluir"   , "AxInclui", 0, 3},;
        {"Alterar"   , "AxAltera", 0, 4},;
        {"Excluir"   , "AxDeleta", 0, 5};
    }

    BEGIN SEQUENCE

        dbSelectArea("ZZ2")
        dbSetOrder(1)

        IF !Empty(cCodigoZZ1)

            cCadastro := "Ocorrencias - Controle " + cCodigoZZ1

            cFiltro := "AllTrim(ZZ2->ZZ2_CONFOR) == '" + ;
                       cCodigoZZ1 + "'"

            FilBrowse("ZZ2", @aIndexZZ2, @cFiltro)

            lFiltrado := .T.

        ENDIF

        mBrowse(1, 1, 22, 75, "ZZ2", , , , , , aCores)

        IF lFiltrado
            EndFilBrw("ZZ2", aIndexZZ2)
            lFiltrado := .F.
        ENDIF

    RECOVER USING oError

        IF lFiltrado
            EndFilBrw("ZZ2", aIndexZZ2)
        ENDIF

        U_GRAVARLOGTCC("STTZZ2", oError)

        MsgStop("Ocorreu um erro nas ocorrencias do fornecedor.",;
                "Ocorrencias do Fornecedor")

    END SEQUENCE

    ErrorBlock(bError)
    RestArea(aArea)

RETURN NIL