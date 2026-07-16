REQUEST HB_CODEPAGE_PT850

FUNCTION Main()
    LOCAL cNome := "Jo∆o Silva", nSalarioBruto := 3500.50, lAtive := .T., dAdmissao, cDepto := "RH"

    HB_CDPSELECT("PT850") // Ativa a pagina de c¢digo para Portuguàs
    SET DATE BRITISH // Define o formato de data para DD/MM/YYYY
    dAdmissao := CToD("16/07/2026")
    
    QOut("Nome: " + cNome)
    QOut("Sal†rio bruto: R$ " + AllTrim(Str(nSalarioBruto, 10, 2)))
    QOut("Ativo: " + If(lAtive, "Sim", "N∆o"))
    QOut("Data de admiss∆o: " + DToC(dAdmissao))
    QOut("C¢digo do departamento: " + cDepto)

RETURN NIL