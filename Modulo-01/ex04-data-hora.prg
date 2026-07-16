// ============================================
// NOME: ex04-data-hora.prg
// DESCRIÇÃO: ficha com data e hora atuais
// ============================================

FUNCTION Main()

    LOCAL cNome  := "Apolo Marques"
    LOCAL nIdade := 20

    QOut("==============================")
    QOut("Nome : " + cNome)
    QOut("Idade: " + Str(nIdade))
    QOut("Data : " + DToC(Date()))
    QOut("Hora : " + Time())
    QOut("==============================")

RETURN NIL

FUNCTION OutraFuncao()

RETURN NIL