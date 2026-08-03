//========================================================
// STTIP04B.PRW
// Interacoes (todas)
// Rotina chamada pelo menu
//========================================================

#include "protheus.ch"

USER FUNCTION STTIP04B()

    LOCAL cFiltro := ""

    PRIVATE cCadastro := "Interacoes"

    PRIVATE aRotina := {;
        {"Pesquisar" , "AxPesqui" , 0, 1},;
        {"Visualizar", "AxVisual" , 0, 2},;
        {"Incluir"   , "AxInclui" , 0, 3},;
        {"Alterar"   , "AxAltera" , 0, 4},;
        {"Excluir"   , "AxDeleta" , 0, 5} ;
    }

    dbSelectArea("SZ2")
    dbSetOrder(1)
    dbGoTop()

    mBrowse(1,1,22,75,"SZ2",,,,,,cFiltro)

RETURN NIL