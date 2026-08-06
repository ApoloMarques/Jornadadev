#include "protheus.ch"

/*/{Protheus.doc} STTZZ2
Consulta geral das ocorrencias de fornecedores.
/*/
USER FUNCTION STTZZ2()

    BrowseZZ2("")

RETURN NIL

/*/{Protheus.doc} STTZZ2FLT
Consulta das ocorrencias filtradas pelo controle ZZ1.
/*/
USER FUNCTION STTZZ2FLT(cCodigo)

    DEFAULT cCodigo := ""

    BrowseZZ2(AllTrim(cCodigo))

RETURN NIL

/*/{Protheus.doc} BrowseZZ2
Monta o browse geral ou filtrado da tabela ZZ2.
/*/
STATIC FUNCTION BrowseZZ2(cCodigo)

    LOCAL aArea   := GetArea()
    LOCAL bError  := ErrorBlock({|oError| Break(oError)})
    LOCAL oError
    LOCAL cFiltro := ""
    LOCAL aCores  := {;
        {"U_PERCNAOCONFORME(ZZ2->ZZ2_QTDTOT-ZZ2->ZZ2_QTDNOK," + ;
         "ZZ2->ZZ2_QTDNOK) > " + ;
         "POSICIONE('ZZ1',1,XFILIAL('ZZ1')+" + ;
         "ZZ2->ZZ2_CODZZ1,'ZZ1_TOLERA')", "BR_VERMELHO"},;
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

    IF !Empty(cCodigo)
        cCadastro := "Ocorrencias - Controle " + cCodigo
        cFiltro   := "AllTrim(ZZ2->ZZ2_CODZZ1) == '" + ;
                     cCodigo + "'"
    ENDIF

    BEGIN SEQUENCE

        dbSelectArea("ZZ2")
        dbSetOrder(1)

        mBrowse(1, 1, 22, 75, "ZZ2", , , , , , ;
                aCores, , , , , .F., , , cFiltro)

    RECOVER USING oError

        U_STTLOGTCC("STTZZ2", oError)
        MsgStop("Ocorreu um erro nas ocorrencias do fornecedor.",;
                "Ocorrencias do Fornecedor")

    END SEQUENCE

    ErrorBlock(bError)
    RestArea(aArea)

RETURN NIL
RETURN NIL