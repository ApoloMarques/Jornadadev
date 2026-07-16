REQUEST HB_CODEPAGE_PT850

#define PI 3.14159

FUNCTION Main()
    

    LOCAL nRaio := 0.0
    LOCAL nAltura := 0.0
    LOCAL nBase := 0.0
    LOCAL nPeso := 0.0
    LOCAL nAreaCirculo := 0.0
    LOCAL nHipotenusa := 0.0
    LOCAL nIMC := 0.0

    HB_CDPSELECT("PT850")

    INPUT "Raio do c¡rculo (cm): " TO nRaio
    INPUT "Altura (cm): " TO nAltura
    INPUT "Base do triƒngulo retƒngulo (cm): " TO nBase
    INPUT "Peso (kg): " TO nPeso

    nAreaCirculo := PI * nRaio * nRaio
    nHipotenusa := Sqrt(nBase * nBase + nAltura * nAltura)
    nIMC := nPeso / ((nAltura / 100) * (nAltura / 100))

    QOut("µrea do c¡rculo: " + AllTrim(Str(nAreaCirculo, 10, 2)))
    QOut("Hipotenusa: " + AllTrim(Str(nHipotenusa, 10, 2)))
    QOut("IMC: " + AllTrim(Str(nIMC, 10, 2)))

RETURN NIL
