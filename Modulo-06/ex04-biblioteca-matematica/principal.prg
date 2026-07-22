REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    HB_CDPSELECT("PT850")


    SET PROCEDURE TO matematica.prg

    ? "Fatorial de 5 :", FatorialN(5)
    ? "7 e primo?    :", EhPrimo(7)
    ? "MDC(18,24)    :", MDC(18,24)
    ? "MMC(18,24)    :", MMC(18,24)

RETURN NIL