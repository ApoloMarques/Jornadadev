// ============================================================
// EX06-GRAVACAO-SEGURA.PRW
// Jornada DEV START - Modulo 09 - Exercicio 06
//
// Gravacao segura do cadastro de Contatos - tabela SZ1
// Adaptado para o ambiente Protheus MP8.11
// ============================================================

#include "protheus.ch"

// ------------------------------------------------------------
// ST03SALV
//
// Recebe os dados do contato por parametros, valida os campos
// obrigatorios e grava o registro dentro de uma transacao.
//
// Parametros:
// cCliente = codigo do cliente
// cAssunto = assunto do contato
// cLoja    = loja do cliente
// cNome    = nome do cliente
//
// Retorno:
// .T. = contato gravado com sucesso
// .F. = gravacao cancelada
// ------------------------------------------------------------
USER FUNCTION ST03SALV(cCliente, cAssunto, cLoja, cNome)

    LOCAL lSucesso := .F.
    LOCAL lTravou  := .F.
    LOCAL lNumSX8  := .F.
    LOCAL oErro    := NIL
    LOCAL bErroAnt
    LOCAL cCodigo  := ""

    // Garante valores validos para os parametros recebidos
    IF ValType(cCliente) != "C"
        cCliente := ""
    ENDIF

    IF ValType(cAssunto) != "C"
        cAssunto := ""
    ENDIF

    IF ValType(cLoja) != "C"
        cLoja := ""
    ENDIF

    IF ValType(cNome) != "C"
        cNome := ""
    ENDIF

    cCliente := AllTrim(cCliente)
    cAssunto := AllTrim(cAssunto)
    cLoja    := AllTrim(cLoja)
    cNome    := AllTrim(cNome)

    // Envia erros de execucao para o RECOVER
    bErroAnt := ErrorBlock({|oError| Break(oError)})

    BeginTran()

    BEGIN SEQUENCE

        // ----------------------------------------------------
        // Validacao obrigatoria: Cliente
        // ----------------------------------------------------
        IF Empty(cCliente)

            oErro := ErrorNew()
            oErro:Description := ;
                "O campo Cliente deve ser preenchido."

            Break(oErro)

        ENDIF

        // ----------------------------------------------------
        // Validacao obrigatoria: Assunto
        // ----------------------------------------------------
        IF Empty(cAssunto)

            oErro := ErrorNew()
            oErro:Description := ;
                "O campo Assunto deve ser preenchido."

            Break(oErro)

        ENDIF

        // ----------------------------------------------------
        // Busca o nome do cliente caso nao tenha sido informado
        // ----------------------------------------------------
        IF Empty(cNome)

            cNome := POSICIONE(;
                "SA1", ;
                1, ;
                xFilial("SA1") + cCliente + cLoja, ;
                "A1_NOME" ;
            )

            cNome := AllTrim(cNome)

        ENDIF

        // ----------------------------------------------------
        // Obtem o proximo codigo da tabela SZ1
        // ----------------------------------------------------
        cCodigo := GetSXENum("SZ1", "Z1_CODIGO")
        lNumSX8 := .T.

        IF Empty(cCodigo)

            oErro := ErrorNew()
            oErro:Description := ;
                "Nao foi possivel gerar o codigo do contato."

            Break(oErro)

        ENDIF

        // ----------------------------------------------------
        // Seleciona a tabela de Contatos
        // ----------------------------------------------------
        dbSelectArea("SZ1")
        dbSetOrder(1)

        // ----------------------------------------------------
        // Bloqueia um novo registro para inclusao
        // ----------------------------------------------------
        lTravou := RecLock("SZ1", .T.)

        IF !lTravou

            oErro := ErrorNew()
            oErro:Description := ;
                "Nao foi possivel bloquear a tabela SZ1."

            Break(oErro)

        ENDIF

        // ----------------------------------------------------
        // Grava os dados do contato
        // ----------------------------------------------------
        SZ1->Z1_FILIAL  := xFilial("SZ1")
        SZ1->Z1_CODIGO  := cCodigo
        SZ1->Z1_CLIENTE := cCliente
        SZ1->Z1_LOJACLI := cLoja
        SZ1->Z1_NOME    := cNome
        SZ1->Z1_ASSUNTO := cAssunto
        SZ1->Z1_DATA    := dDataBase
        SZ1->Z1_HORA    := Time()

        // Finaliza a alteracao do registro
        SZ1->(MsUnlock())
        lTravou := .F.

        // Confirma o codigo reservado
        ConfirmSX8()
        lNumSX8 := .F.

        // Confirma a transacao
        CommitTran()

        lSucesso := .T.

        MsgInfo(;
            "Contato gravado com seguranca." + CRLF + ;
            "Codigo: " + cCodigo, ;
            "Gravacao concluida" ;
        )

    RECOVER USING oErro

        // Libera o registro caso ainda esteja bloqueado
        IF lTravou

            SZ1->(MsUnlock())
            lTravou := .F.

        ENDIF

        // Cancela o codigo reservado, caso exista
        IF lNumSX8

            RollBackSX8()
            lNumSX8 := .F.

        ENDIF

        // Desfaz toda a transacao
        RollBackTran()

        // Exibe uma mensagem amigavel
        IF ValType(oErro) == "O"

            MsgStop(;
                "Nao foi possivel gravar o contato." + CRLF + ;
                oErro:Description, ;
                "Gravacao cancelada" ;
            )

            U_GRAVARLOG("ST03SALV", oErro)

        ELSE

            MsgStop(;
                "Nao foi possivel gravar o contato." + CRLF + ;
                "Verifique os dados informados.", ;
                "Gravacao cancelada" ;
            )

            U_GRAVARLOG("ST03SALV", NIL)

        ENDIF

        lSucesso := .F.

    END SEQUENCE

    // Restaura o tratamento de erros anterior
    ErrorBlock(bErroAnt)

RETURN lSucesso

// ------------------------------------------------------------
// ST03TEST
//
// Teste obrigatorio do exercicio:
// chama a gravacao com o Cliente vazio para provocar o erro.
//
// Nenhum registro deve ser gravado.
// ------------------------------------------------------------
USER FUNCTION ST03TEST()

    LOCAL lResultado := .F.

    lResultado := U_ST03SALV(;
        "", ;
        "TESTE DE GRAVACAO SEGURA", ;
        "01", ;
        "" ;
    )

    IF !lResultado

        MsgInfo(;
            "Teste concluido." + CRLF + ;
            "A gravacao foi cancelada corretamente.", ;
            "Exercicio 06" ;
        )

    ENDIF

RETURN NIL