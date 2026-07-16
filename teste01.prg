REQUEST HB_CODEPAGE_UTF8

FUNCTION Soma(num1, num2)
    LOCAL nResult
    nResult := num1 + num2
    QOut(nResult)
RETURN NIL

FUNCTION Main()
    LOCAL nTmp
    hb_cdpSelect("UTF8")
    
    // Atribuindo a uma variável temporária para evitar o erro de sintaxe
    nTmp := Soma(10, 5) 
RETURN NIL