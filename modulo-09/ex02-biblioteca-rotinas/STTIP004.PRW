// ============================================
// STTIP004.PRW
// Interacoes de um Contato (SZ2)
// Chamada a partir da STTIP003
// ============================================

#include "protheus.ch"

USER FUNCTION STTIP004()

    LOCAL cFiltro := ""
    LOCAL cCodigSZ1 := SZ1->Z1_CODIGO

    PRIVATE cCadastro := "Interacoes - Contato " + AllTrim(cCodigSZ1)

    PRIVATE aRotina := {;
        {"Pesquisar" , "AxPesqui", 0, 1},;
        {"Visualizar", "AxVisual", 0, 2},;
        {"Incluir"   , "AxInclui", 0, 3},;
        {"Alterar"   , "AxAltera", 0, 4},;
        {"Excluir"   , "AxDeleta", 0, 5};
    }

    cFiltro := "Z2_CONTAT == '" + cCodigSZ1 + "'"

    dbSelectArea("SZ2")
    dbSetOrder(1)
    dbSeek(xFilial("SZ2") + cCodigSZ1)

    mBrowse(1, 1, 22, 75, "SZ2", , , , , , , , , , , ;
        .F., , , cFiltro)

RETURN NIL