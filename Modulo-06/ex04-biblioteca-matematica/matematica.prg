FUNCTION FatorialN(nN)

    LOCAL nI
    LOCAL nFat := 1

    FOR nI := 2 TO nN
        nFat *= nI
    NEXT

RETURN nFat


FUNCTION EhPrimo(nN)

    LOCAL nI

    IF nN < 2
        RETURN .F.
    ENDIF

    FOR nI := 2 TO nN - 1
        IF nN % nI == 0
            RETURN .F.
        ENDIF
    NEXT

RETURN .T.


FUNCTION MDC(nA, nB)

    LOCAL nAux

    DO WHILE nB <> 0
        nAux := nB
        nB := nA % nB
        nA := nAux
    ENDDO

RETURN nA


FUNCTION MMC(nA, nB)

RETURN ( nA * nB ) / MDC(nA, nB)