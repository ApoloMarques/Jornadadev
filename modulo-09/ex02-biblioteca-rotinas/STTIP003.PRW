// ============================================
// STTIP003.PRW
// Cadastro de Contatos (mBrowse)
// Modulo 09 - Exercicios 06, 07a e 07b
// Adaptado para Protheus MP8.11
// ============================================

#include "protheus.ch"

USER FUNCTION STTIP003()

    LOCAL cFiltro := ""
    LOCAL aColors

    PRIVATE cCadastro := "Contatos"

    PRIVATE aRotina := {;
        {"Pesquisar"   , "AxPesqui"   , 0, 1},;
        {"Visualizar"  , "AxVisual"   , 0, 2},;
        {"Incluir"     , "AxInclui"   , 0, 3},;
        {"Alterar"     , "AxAltera"   , 0, 4},;
        {"Excluir"     , "U_VALEXCS1" , 0, 5},;
        {"Interacoes"  , "U_STTIP004" , 0, 6},;
        {"Teste Ex06"  , "U_TSTBOT"   , 0, 6},;
        {"Teste Ex07b" , "U_TST07B"   , 0, 6};
    }

    aColors := {;
        {"SZ1->Z1_DATA >= dDataBase - 7" , "BR_GREEN"},;
        {"SZ1->Z1_DATA >= dDataBase - 30", "BR_YELLOW"},;
        {".T."                           , "BR_RED"};
    }

    dbSelectArea("SZ1")
    dbSetOrder(1)
    dbSeek(xFilial("SZ1"))

    mBrowse(1, 1, 22, 75, "SZ1", , , , , , ;
        aColors, , , , , .F., , , cFiltro)

RETURN NIL

// ------------------------------------------------------------
// TSTBOT
// Exercicio 06
// Testa a validacao do campo Cliente vazio.
// ------------------------------------------------------------
USER FUNCTION TSTBOT()

    LOCAL cCliente := ""
    LOCAL cErro    := ""
    LOCAL lSucesso := .F.

    BEGIN SEQUENCE

        IF Empty(cCliente)
            Break("O campo Cliente deve ser preenchido.")
        ENDIF

        lSucesso := .T.

    RECOVER USING cErro

        IF ValType(cErro) != "C"
            cErro := "Erro durante a validacao do contato."
        ENDIF

        MsgStop(;
            "Nao foi possivel gravar o contato." + CRLF + ;
            cErro + CRLF + CRLF + ;
            "Nenhum registro foi gravado.", ;
            "Gravacao cancelada" ;
        )

        lSucesso := .F.

    END SEQUENCE

    IF !lSucesso

        MsgInfo(;
            "Teste concluido com sucesso." + CRLF + ;
            "A validacao identificou o Cliente vazio.", ;
            "Exercicio 06" ;
        )

    ENDIF

RETURN NIL

// ------------------------------------------------------------
// VALEXCS1
// Exercicio 07a - Integridade referencial
// Impede excluir contato com interacoes vinculadas.
// ------------------------------------------------------------
USER FUNCTION VALEXCS1()

    LOCAL cContato := SZ1->Z1_CODIGO
    LOCAL cChave   := ""
    LOCAL lExiste  := .F.
    LOCAL nArea    := Select()

    IF Empty(cContato)

        MsgStop(;
            "Nenhum contato foi selecionado.", ;
            "Exclusao cancelada" ;
        )

        RETURN NIL

    ENDIF

    cChave := xFilial("SZ2") + cContato

    dbSelectArea("SZ2")
    dbSetOrder(1)

    lExiste := dbSeek(cChave)

    dbSelectArea(nArea)

    IF lExiste

        MsgStop(;
            "Nao e possivel excluir o contato " + cContato + "." + CRLF + ;
            "Existem interacoes vinculadas a ele.", ;
            "Integridade referencial" ;
        )

        RETURN NIL

    ENDIF

    IF MsgYesNo(;
        "Confirma a exclusao do contato " + cContato + "?", ;
        "Excluir contato" ;
    )

        AxDeleta()

    ENDIF

RETURN NIL

// ------------------------------------------------------------
// EXECSEG
// Exercicio 07b - Executor seguro generico
//
// Adaptacao para MP8.11:
// O bloco deve retornar .T. para sucesso ou .F. para falha.
// Nao provoca Break dentro do Eval, pois isso encerra o
// runtime do ambiente MP8.11.
//
// Retorno:
// .T. = bloco executado com sucesso
// .F. = bloco falhou ou retornou valor invalido
// ------------------------------------------------------------
USER FUNCTION EXECSEG(bBloco, cMsgErro)

    LOCAL lResultado := .F.
    LOCAL lSucesso   := .F.
    LOCAL cErro      := ""

    IF ValType(bBloco) != "B"

        MsgStop(;
            "O parametro recebido nao e um bloco de codigo.", ;
            "Executor seguro" ;
        )

        RETURN .F.

    ENDIF

    IF ValType(cMsgErro) != "C"
        cMsgErro := "Falha ao executar o bloco."
    ENDIF

    BEGIN SEQUENCE

        lResultado := Eval(bBloco)

        IF ValType(lResultado) != "L"
            cErro := "O bloco nao retornou um valor logico."
            lSucesso := .F.
        ELSE
            lSucesso := lResultado
        ENDIF

    RECOVER USING cErro

        lSucesso := .F.

        IF ValType(cErro) != "C"
            cErro := "Erro nao identificado pelo ambiente."
        ENDIF

    END SEQUENCE

    IF !lSucesso

        IF Empty(cErro)
            cErro := "O bloco retornou .F."
        ENDIF

        GravaLog7B(cMsgErro + " - " + cErro)

        MsgStop(;
            cMsgErro + CRLF + CRLF + ;
            "Detalhe: " + cErro + CRLF + CRLF + ;
            "O erro foi registrado no log.", ;
            "Executor seguro" ;
        )

    ENDIF

RETURN lSucesso

// ------------------------------------------------------------
// TST07B
// Testa o executor em dois cenarios:
//
// 1. Bloco retorna .T.
// 2. Bloco retorna .F.
// ------------------------------------------------------------
USER FUNCTION TST07B()

    LOCAL lTesteOk   := .F.
    LOCAL lTesteErro := .T.

    lTesteOk := U_EXECSEG(;
        {|| .T.}, ;
        "Falha no bloco executado com sucesso." ;
    )

    lTesteErro := U_EXECSEG(;
        {|| .F.}, ;
        "Falha controlada no Exercicio 07b." ;
    )

    MsgInfo(;
        "Resultado dos testes:" + CRLF + CRLF + ;
        "Bloco sem falha: " + IIF(lTesteOk, ".T.", ".F.") + CRLF + ;
        "Bloco com falha: " + IIF(lTesteErro, ".T.", ".F.") + CRLF + CRLF + ;
        "Resultado esperado: .T. e .F.", ;
        "Exercicio 07b" ;
    )

RETURN NIL

// ------------------------------------------------------------
// GravaLog7B
// Registra falhas do executor em arquivo texto.
// Usa MemoRead/MemoWrite para compatibilidade com MP8.11.
// ------------------------------------------------------------
STATIC FUNCTION GravaLog7B(cMensagem)

    LOCAL cArquivo  := "\system\ex07b-executor.log"
    LOCAL cConteudo := ""
    LOCAL cLinha    := ""

    IF ValType(cMensagem) != "C"
        cMensagem := "Falha sem descricao."
    ENDIF

    IF File(cArquivo)
        cConteudo := MemoRead(cArquivo)
    ENDIF

    cLinha := DToS(Date()) + " " + Time() + " | "
    cLinha += AllTrim(cMensagem) + CRLF

    MemoWrite(cArquivo, cConteudo + cLinha)

RETURN NIL