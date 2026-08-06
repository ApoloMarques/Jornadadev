#include "protheus.ch"
#include "fileio.ch"

/*/{Protheus.doc} NomeFornecedor
Retorna o nome do fornecedor cadastrado na SA2.
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
/*/
USER FUNCTION NomeProduto(cProduto)

    DEFAULT cProduto := ""

    IF Empty(cProduto)
        RETURN ""
    ENDIF

RETURN AllTrim(Posicione("SB1", 1, ;
               xFilial("SB1") + cProduto, "B1_DESC"))

/*/{Protheus.doc} PercNaoConforme
Calcula o percentual de itens nao conformes.
/*/
USER FUNCTION PercNaoConforme(nQtdOk, nQtdNok)

    DEFAULT nQtdOk  := 0
    DEFAULT nQtdNok := 0

RETURN IIF(nQtdOk + nQtdNok > 0, ;
           (nQtdNok / (nQtdOk + nQtdNok)) * 100, 0)

/*/{Protheus.doc} CertificadoVencendo
Retorna verdadeiro se o certificado vencer em ate 30 dias.
/*/
USER FUNCTION CertificadoVencendo(dValidade)

RETURN ValType(dValidade) == "D" .AND. ;
       !Empty(dValidade)         .AND. ;
       dValidade >= dDataBase    .AND. ;
       dValidade <= dDataBase + 30

/*/{Protheus.doc} STTLogTCC
Grava informacoes tecnicas dos erros do TCC.
/*/
USER FUNCTION STTLogTCC(cFuncao, oErro)

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