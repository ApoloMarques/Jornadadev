REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

	LOCAL cPrimeiro := "", cSegundo := ""
	LOCAL nPrimeiro := 0, nSegundo := 0

	HB_CDPSELECT("PT850")

	ACCEPT "Digite o primeiro n£mero: " TO cPrimeiro
	nPrimeiro := VAL(cPrimeiro)
	ACCEPT "Digite o segundo n£mero: " TO cSegundo
	nSegundo := VAL(cSegundo)

	IF nPrimeiro == nSegundo
		QOut("Os valores sÆo iguais.")
	ELSE
		IF nPrimeiro > nSegundo
			? "Maior valor:", nPrimeiro
			? "Menor valor:", nSegundo
		ELSE
			? "Maior valor:", nSegundo
			? "Menor valor:", nPrimeiro
		ENDIF
	ENDIF

	RETURN NIL

