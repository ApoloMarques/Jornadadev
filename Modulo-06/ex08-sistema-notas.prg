REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL aAlunos := {}
    LOCAL aAluno
    LOCAL cTexto := ""
    LOCAL cNome
    LOCAL nQtd
    LOCAL nI, nJ
    LOCAL nMedia

    HB_CDPSELECT("PT850")

    CLS
    ? "==============================="
    ? "      SISTEMA DE NOTAS"
    ? "==============================="
    ?

    ACCEPT "Quantidade de alunos: " TO cTexto
    nQtd := Val(cTexto)

    FOR nI := 1 TO nQtd

        ACCEPT "Nome: " TO cNome

        aAluno := { AllTrim(cNome) }
        nMedia := 0

        FOR nJ := 1 TO 4

            ACCEPT "Nota " + LTrim(Str(nJ)) + ": " TO cTexto

            AAdd(aAluno, Val(cTexto))
            nMedia += Val(cTexto)

        NEXT

        AAdd(aAluno, nMedia / 4)
        AAdd(aAlunos, aAluno)

    NEXT

    CLS
    ? "====== APROVADOS ======"

    FOR nI := 1 TO Len(aAlunos)

        IF aAlunos[nI][6] >= 7
            ? aAlunos[nI][1], "- Media:", aAlunos[nI][6]
        ENDIF

    NEXT

    ?

    ? "====== REPROVADOS ======"

    FOR nI := 1 TO Len(aAlunos)

        IF aAlunos[nI][6] < 7
            ? aAlunos[nI][1], "- Media:", aAlunos[nI][6]
        ENDIF

    NEXT

RETURN NIL