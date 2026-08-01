// X3_VALID = "U_VALCLI001()"

#include "protheus.ch"

USER FUNCTION VALCLI001()

    IF !ExistCpo("SA1", xFilial("SA1")+M->ZA2_CLIENT+M->ZA2_LOJA,1)
        MsgAlert("Cliente não cadastrado na SA1!", "Atenção")
        RETURN .F.
    ENDIF

RETURN .T.