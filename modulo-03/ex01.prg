FUNCTION Main()
/* 
LOCAL - ideal
PRIVATE - dados ..
PUBLIC - 
STATIC - 
*/
    LOCAL nNumero := 50
    
    Operacoes(nNumero)

RETURN NIL

FUNCTION Operacoes(nNum) 
    LOCAL nNumero := 10

    Soma(nNumero)
    Substrai(nNumero)

RETURN NIL       

FUNCTION Soma(nNum)
    QOut(nNum)
    QOut("Função Soma")
RETURN NIL

FUNCTION Substrai(nNum)
    QOut(nNum)  
    QOut("Função Substrai")
RETURN NIL