#include "protheus.ch"    

USER FUNCTION STCEP(cCEP, cRetorno)

    LOCAL aCEPs := {;
        {"18035000", "Centro", "Sorocaba",       "SP"},;
        {"01001000", "Se",     "Sao Paulo",      "SP"},;
        {"20040002", "Centro", "Rio de Janeiro", "RJ"};
    }

    LOCAL cCEPBusca  := ""
    LOCAL cResultado := ""
    LOCAL nPos       := 0

    // Remove o hifen para comparar com os CEPs do array
    cCEPBusca := AllTrim(cCEP)
    cCEPBusca := StrTran(cCEPBusca, "-", "")

    // Procura o CEP na primeira posicao de cada item
    nPos := AScan(aCEPs, {|aItem| aItem[1] == cCEPBusca})

    IF nPos > 0

        DO CASE

        CASE Upper(AllTrim(cRetorno)) == "BAIRRO"
            cResultado := aCEPs[nPos][2]

        CASE Upper(AllTrim(cRetorno)) == "CIDADE"
            cResultado := aCEPs[nPos][3]

        CASE Upper(AllTrim(cRetorno)) == "UF"
            cResultado := aCEPs[nPos][4]

        ENDCASE

    ENDIF

RETURN cResultado


USER FUNCTION STCEPTESTE()

    LOCAL cCEP    := "18035-000"
    LOCAL cBairro := ""
    LOCAL cCidade := ""
    LOCAL cUF     := ""
    LOCAL cTexto  := ""
    LOCAL cQuebra := Chr(13) + Chr(10)

    cBairro := U_STCEP(cCEP, "BAIRRO")
    cCidade := U_STCEP(cCEP, "CIDADE")
    cUF     := U_STCEP(cCEP, "UF")

    cTexto := "Bairro: " + cBairro + cQuebra +;
              "Cidade: " + cCidade + cQuebra +;
              "UF: "     + cUF

    MsgAlert(cTexto, "Teste do CEP")

RETURN NIL