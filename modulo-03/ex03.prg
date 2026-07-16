FUNCTION Main()

    LOCAL nIdade := 50
    LOCAL lAtivo := .F.

    IF(nIdade > 60 .AND. lAtivo)
        ? "A pessoa é idosa e está ativa."
    ENDIF

    IF(nIdade < 18 .OR. !lAtivo)
        ? "A pessoa não é idosa ou não está ativa."
    ENDIF

RETURN NIL
