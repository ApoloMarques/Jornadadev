REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cNome, cDisc, cNota
    LOCAL nNota1, nNota2

    HB_CDPSELECT("PT850")

    // Nome
    WHILE .T.
        ACCEPT "Nome: " TO cNome
        IF Len(Trim(cNome)) > 0
            EXIT
        ENDIF
        ? "Nome invalido."
    ENDDO

    // Disciplina
    WHILE .T.
        ACCEPT "Disciplina: " TO cDisc
        IF Len(cDisc) == 3 .AND. cDisc == Upper(cDisc)
            EXIT
        ENDIF
        ? "Disciplina invalida."
    ENDDO

    // Nota 1
    WHILE .T.
        ACCEPT "Nota 1: " TO cNota
        nNota1 := Val(cNota)
        IF nNota1 >= 0 .AND. nNota1 <= 10
            EXIT
        ENDIF
        ? "Nota invalida."
    ENDDO

    // Nota 2
    WHILE .T.
        ACCEPT "Nota 2: " TO cNota
        nNota2 := Val(cNota)
        IF nNota2 >= 0 .AND. nNota2 <= 10
            EXIT
        ENDIF
        ? "Nota invalida."
    ENDDO

    ?
    ? "Nome.......:", cNome
    ? "Disciplina.:", cDisc
    ? "Media......:", ( nNota1 + nNota2 ) / 2

RETURN NIL