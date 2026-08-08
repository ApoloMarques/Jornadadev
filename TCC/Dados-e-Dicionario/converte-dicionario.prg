REQUEST DBFCDX

PROCEDURE Main()

    LOCAL aArquivos := { ;
        "six990", ;
        "sx2990", ;
        "sx3990", ;
        "sx7990", ;
        "sxb990", ;
        "zz1990", ;
        "zz2990" ;
    }

    LOCAL cArquivo

    RddSetDefault("DBFCDX")

    FOR EACH cArquivo IN aArquivos
        ExportaCSV(cArquivo)
    NEXT

    ? "Conversao concluida."
    Inkey(0)

RETURN


STATIC PROCEDURE ExportaCSV(cBase)

    LOCAL cDBF    := cBase + ".dbf"
    LOCAL cCSV    := cBase + ".csv"
    LOCAL nHandle
    LOCAL nCampo
    LOCAL cLinha

    IF !File(cDBF)
        ? "Arquivo nao encontrado:", cDBF
        RETURN
    ENDIF

    DbUseArea(.T., "DBFCDX", cDBF, "TMP", .T., .F.)

    nHandle := FCreate(cCSV)

    IF nHandle < 0
        ? "Erro ao criar:", cCSV
        DbCloseArea()
        RETURN
    ENDIF

    // Cabecalho
    cLinha := ""

    FOR nCampo := 1 TO FCount()

        IF nCampo > 1
            cLinha += ","
        ENDIF

        cLinha += '"' + FieldName(nCampo) + '"'

    NEXT

    FWrite(nHandle, cLinha + Chr(13) + Chr(10))

    DbGoTop()

    WHILE !Eof()

        cLinha := ""

        FOR nCampo := 1 TO FCount()

            IF nCampo > 1
                cLinha += ","
            ENDIF

            cLinha += CsvValor(FieldGet(nCampo))

        NEXT

        FWrite(nHandle, cLinha + Chr(13) + Chr(10))

        DbSkip()

    ENDDO

    FClose(nHandle)
    DbCloseArea()

    ? "Gerado:", cCSV

RETURN


STATIC FUNCTION CsvValor(xValor)

    LOCAL cValor := ""

    DO CASE

    CASE ValType(xValor) == "C"
        cValor := StrTran(xValor, '"', '""')
        cValor := '"' + AllTrim(cValor) + '"'

    CASE ValType(xValor) == "N"
        cValor := AllTrim(Str(xValor))

    CASE ValType(xValor) == "D"
        cValor := '"' + ;
                  StrZero(Year(xValor), 4) + "-" + ;
                  StrZero(Month(xValor), 2) + "-" + ;
                  StrZero(Day(xValor), 2) + '"'

    CASE ValType(xValor) == "L"
        cValor := IIF(xValor, '"TRUE"', '"FALSE"')

    OTHERWISE
        cValor := '""'

    ENDCASE

RETURN cValor