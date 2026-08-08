#include "protheus.ch"

/*/{Protheus.doc} STTZZ1
Rotina de manutencao do Controle de Fornecimento - ZZ1.

Apresenta o cadastro em mBrowse com legenda de validade
do certificado e acesso as ocorrencias vinculadas.

@type     function
@author   Jose Apolo Marques Nascimento
@since    04/08/2026
/*/
USER FUNCTION STTZZ1()

    LOCAL aArea  := GetArea()
    LOCAL bError := ErrorBlock({|oError| Break(oError)})
    LOCAL oError
    LOCAL aCores := {;
        {"ZZ1->ZZ1_VALCER < dDataBase",            "BR_VERMELHO"},;
        {"U_CERTIFICADOVENCENDO(ZZ1->ZZ1_VALCER)", "BR_AMARELO"},;
        {".T.",                                     "BR_VERDE"};
    }

    PRIVATE cCadastro := "Controle de Fornecimento"
    PRIVATE aRotina   := {;
        {"Pesquisar"  , "AxPesqui"    , 0, 1},;
        {"Visualizar" , "AxVisual"    , 0, 2},;
        {"Incluir"    , "AxInclui"    , 0, 3},;
        {"Alterar"    , "AxAltera"    , 0, 4},;
        {"Excluir"    , "AxDeleta"    , 0, 5},;
        {"Ocorrencias", "U_STTZZ1OCO", 0, 6};
    }

    BEGIN SEQUENCE

        dbSelectArea("ZZ1")
        dbSetOrder(1)

        mBrowse(6, 1, 22, 75, "ZZ1", , , , , , aCores)

    RECOVER USING oError

        U_GRAVARLOGTCC("STTZZ1", oError)

        MsgStop("Ocorreu um erro no Controle de Fornecimento.",;
                "Controle de Fornecimento")

    END SEQUENCE

    ErrorBlock(bError)
    RestArea(aArea)

RETURN NIL

/*/{Protheus.doc} STTZZ1OCO
Abre as ocorrencias relacionadas ao controle ZZ1 selecionado.

@type     function
@author   Jose Apolo Marques Nascimento
@since    04/08/2026
/*/
USER FUNCTION STTZZ1OCO()

    LOCAL aArea   := GetArea()
    LOCAL bError  := ErrorBlock({|oError| Break(oError)})
    LOCAL oError
    LOCAL cCodigo := ""

    BEGIN SEQUENCE

        dbSelectArea("ZZ1")

        cCodigo := AllTrim(ZZ1->ZZ1_CODIGO)

        IF !Empty(cCodigo)

            U_STTZZ2FLT(cCodigo)

        ELSE

            MsgAlert("Selecione um controle para consultar as ocorrencias.",;
                     "Controle de Fornecimento")

        ENDIF

    RECOVER USING oError

        U_GRAVARLOGTCC("STTZZ1OCO", oError)

        MsgStop("Nao foi possivel consultar as ocorrencias.",;
                "Controle de Fornecimento")

    END SEQUENCE

    ErrorBlock(bError)
    RestArea(aArea)

RETURN NIL