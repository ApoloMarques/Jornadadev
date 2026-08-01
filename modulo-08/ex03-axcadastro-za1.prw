#include "protheus.ch"

USER FUNCTION STTIP001()

    PRIVATE cCadastro := "Pets"

    dbSelectArea("ZA2")
    dbSetOrder(1)

    AxCadastro("ZA2", "Pets", ".T.", ".T.")

RETURN NIL