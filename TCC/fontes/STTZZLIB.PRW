#include "protheus.ch"
#include "fileio.ch"

/*/{Protheus.doc} NomeFornecedor
Retorna o nome do fornecedor cadastrado na SA2.

@param cFornec, character, Codigo do fornecedor
@param cLoja,   character, Loja do fornecedor
@return character, Nome do fornecedor
/*/
USER FUNCTION NomeFornecedor(cFornec, cLoja)

    DEFAULT cFornec := ""
    DEFAULT cLoja   := ""

    IF Empty(cFornec)
        RETURN ""
    ENDIF

RETURN AllTrim(Posicione("SA2", 1, ;
               xFilial("SA2") + cFornec + cLoja, "A2_NOME"))

/*/{Protheus.doc} NomeProduto
Retorna a descricao do produto cadastrado na SB1.

@param cCodPro, character, Codigo do produto
@return character, Descricao do produto
/*/
USER FUNCTION NomeProduto(cCodPro)

    DEFAULT cCodPro := ""

    IF Empty(cCodPro)
        RETURN ""
    ENDIF

RETURN AllTrim(Posicione("SB1", 1, ;
               xFilial("SB1") + cCodPro, "B1_DESC"))

/*/{Protheus.doc} PercNaoConforme
Calcula o percentual de itens nao conformes.

@param nOk,  numeric, Quantidade conforme
@param nNok, numeric, Quantidade nao conforme
@return numeric, Percentual de nao conformidade
/*/
USER FUNCTION PercNaoConforme(nOk, nNok)

    DEFAULT nOk  := 0
    DEFAULT nNok := 0

RETURN IIF(nOk + nNok > 0, ;
           (nNok / (nOk + nNok)) * 100, 0)

/*/{Protheus.doc} CertificadoVencendo
Retorna verdadeiro quando o certificado vence
entre a data atual e os proximos 30 dias.

@param dValCer, date, Data de validade do certificado
@return logical, .T. quando vence em ate 30 dias
/*/
USER FUNCTION CertificadoVencendo(dValCer)

RETURN ValType(dValCer) == "D" .AND. ;
       !Empty(dValCer)         .AND. ;
       dValCer >= dDataBase    .AND. ;
       dValCer <= dDataBase + 30

/*/{Protheus.doc} GravarLogTCC
Grava em arquivo as informacoes tecnicas
dos erros tratados pelas rotinas do TCC.

@param cFuncao, character, Funcao onde ocorreu o erro
@param oErro, object, Objeto de erro capturado
@return nil
/*/
USER FUNCTION GravarLogTCC(cFuncao, oErro)

    LOCAL cArqLog := "\system\stt_tcc_" + DToS(Date()) + ".log"
    LOCAL cLinha  := ""
    LOCAL nHandle := -1

    DEFAULT cFuncao := "NAO INFORMADA"
    DEFAULT oErro   := NIL

    cLinha := DToS(Date()) + " " + Time() + " | " + ;
              AllTrim(cFuncao) + " | " + cNomUsr + " | " + ;
              "Empresa: " + cEmpAnt + " Filial: " + cFilAnt

    IF ValType(oErro) == "O"
        cLinha += " | ERRO: " + oErro:Description
        cLinha += " | Func: " + oErro:ProcName + ":" + ;
                  cValToChar(oErro:ProcLine)
        cLinha += " | SubSist: " + oErro:SubSystem
        cLinha += " | Oper: " + oErro:Operation
    ENDIF

    nHandle := FOpen(cArqLog, FO_READWRITE + FO_SHARED)

    IF nHandle < 0
        nHandle := FCreate(cArqLog)
    ENDIF

    IF nHandle >= 0
        FSeek(nHandle, 0, FS_END)
        FWrite(nHandle, cLinha + Chr(13) + Chr(10))
        FClose(nHandle)
    ENDIF

RETURN NIL