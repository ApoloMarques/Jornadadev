// ============================================
// STTIPLIB.PRW
// Biblioteca de funcoes comuns do modulo TIP
// ============================================

#include "protheus.ch"

// -----------------------------------------------
// NomeCliente
// Retorna o nome do cliente a partir do codigo/loja
// -----------------------------------------------
STATIC FUNCTION NomeCliente(cCodigo, cLoja)

    LOCAL cFilial := xFilial("SA1")
    LOCAL cNome   := ""

    IF Empty(cCodigo)
        RETURN ""
    ENDIF

    cNome := POSICIONE("SA1", 1, ;
        cFilial + cCodigo + cLoja, ;
        "A1_NOME")

RETURN AllTrim(cNome)

// -----------------------------------------------
// ProxCodigoSZ1
// Retorna o proximo codigo disponivel para SZ1
// -----------------------------------------------
STATIC FUNCTION ProxCodigoSZ1()

RETURN GetSXENum("SZ1", "Z1_CODIGO")

// -----------------------------------------------
// ProxSequenSZ2
// Retorna a proxima sequencia para um contato na SZ2
// -----------------------------------------------
STATIC FUNCTION ProxSequenSZ2(cContat)

    LOCAL nMax := 0

    dbSelectArea("SZ2")
    dbSetOrder(1)
    dbSeek(xFilial("SZ2") + cContat)

    WHILE !Eof() .AND. ;
          SZ2->Z2_FILIAL == xFilial("SZ2") .AND. ;
          SZ2->Z2_CONTAT == cContat

        nMax := Max(nMax, Val(SZ2->Z2_SEQUEN))
        dbSkip()

    ENDDO

RETURN StrZero(nMax + 1, 3)

// -----------------------------------------------
// DescTipoInteracao
// Retorna a descricao do tipo de interacao
// -----------------------------------------------
STATIC FUNCTION DescTipoInteracao(cTipo)

    LOCAL cDesc := ""

    DO CASE
    CASE cTipo == "E"
        cDesc := "E-mail"

    CASE cTipo == "L"
        cDesc := "Ligacao"

    CASE cTipo == "R"
        cDesc := "Reuniao"

    CASE cTipo == "V"
        cDesc := "Visita"

    CASE cTipo == "W"
        cDesc := "WhatsApp"
    ENDCASE

RETURN cDesc

// -----------------------------------------------
// GRAVARLOG
// Registra os detalhes do erro em arquivo de log
// -----------------------------------------------
USER FUNCTION GRAVARLOG(cFuncao, oErro)

    LOCAL cArqLog := "\logs\advpl_" + DToS(Date()) + ".log"
    LOCAL nHandle := -1
    LOCAL cLinha  := ""

    cLinha := DToS(Date()) + " " + Time() + " | "
    cLinha += AllTrim(cFuncao) + " | "
    cLinha += "Usuario: " + UsrRetName(RetCodUsr()) + " | "
    cLinha += "Empresa: " + cEmpAnt + " | "
    cLinha += "Filial: " + cFilAnt + " | "

    IF oErro != NIL

        cLinha += "ERRO: " + oErro:Description

        IF ValType(oErro:ProcName) == "C"
            cLinha += " | Funcao: " + oErro:ProcName
        ENDIF

        IF ValType(oErro:ProcLine) == "N"
            cLinha += ":" + cValToChar(oErro:ProcLine)
        ENDIF

        IF ValType(oErro:SubSystem) == "C"
            cLinha += " | Subsistema: " + oErro:SubSystem
        ENDIF

        IF ValType(oErro:Operation) == "C"
            cLinha += " | Operacao: " + oErro:Operation
        ENDIF

    ELSE

        cLinha += "Erro de validacao"

    ENDIF

    nHandle := FOpen(cArqLog, FO_READWRITE + FO_SHARED)

    IF nHandle < 0
        nHandle := FCreate(cArqLog)
    ENDIF

    IF nHandle >= 0

        FSeek(nHandle, 0, FS_END)
        FWrite(nHandle, cLinha + CRLF)
        FClose(nHandle)

    ENDIF

RETURN NIL