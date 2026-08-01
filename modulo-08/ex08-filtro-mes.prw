#include "protheus.ch"

USER FUNCTION STTIP002()

    LOCAL aColors := {;
        {"ZA2_DTNASC < dDataBase - 3650", "BR_VERMELHO"},;
        {"ZA2_DTNASC == dDataBase",       "BR_AMARELO"},;
        {".T.",                           "BR_VERDE"};
    }

    PRIVATE cCadastro := "Pets"

    PRIVATE aRotina := {;
        {"Pesquisar" , "AxPesqui"   , 0, 1},;
        {"Visualizar", "AxVisual"   , 0, 2},;
        {"Incluir"   , "AxInclui"   , 0, 3},;
        {"Alterar"   , "AxAltera"   , 0, 4},;
        {"Excluir"   , "AxDeleta"   , 0, 5},;
        {"Sem filtro", "U_STSEMFLT" , 0, 6};
    }

    dbSelectArea("ZA2")
    dbSetOrder(1)

    // Exibe somente os pets cujo mês e ano de nascimento
    // correspondem ao mês e ano da data atual do ambiente.
    SET FILTER TO ;
        Month(ZA2_DTNASC) == Month(dDataBase) .AND. ;
        Year(ZA2_DTNASC)  == Year(dDataBase)

    dbGoTop()

    mBrowse(1, 1, 22, 75, "ZA2", , , , , , aColors)

    // Evita deixar o filtro ativo depois que o browse for fechado.
    dbClearFilter()

RETURN NIL


USER FUNCTION STSEMFLT()

    LOCAL aColors := {;
        {"ZA2_DTNASC < dDataBase - 3650", "BR_VERMELHO"},;
        {"ZA2_DTNASC == dDataBase",       "BR_AMARELO"},;
        {".T.",                           "BR_VERDE"};
    }

    PRIVATE cCadastro := "Pets"

    PRIVATE aRotina := {;
        {"Pesquisar" , "AxPesqui" , 0, 1},;
        {"Visualizar", "AxVisual" , 0, 2},;
        {"Incluir"   , "AxInclui" , 0, 3},;
        {"Alterar"   , "AxAltera" , 0, 4},;
        {"Excluir"   , "AxDeleta" , 0, 5};
    }

    dbSelectArea("ZA2")
    dbSetOrder(1)
    dbClearFilter()
    dbGoTop()

    mBrowse(1, 1, 22, 75, "ZA2", , , , , , aColors)

RETURN NIL