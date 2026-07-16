FUNCTION Main()

    LOCAL nR, nA, nB, nP

    INPUT "Raio círculo: " TO nR
    INPUT "Altura (cm): " TO nA
    INPUT "Base triângulo: " TO nB
    INPUT "Peso (kg): " TO nP

    QOut("Área círculo: " + Alltrim(Str(3.14159 * nR * nR, 10, 2)))
    QOut("Hipotenusa: " + Alltrim(Str(Sqrt(nB * nB + nA * nA), 10, 2)))
    QOut("IMC: " + Alltrim(Str(nP / ((nA / 100) * (nA / 100)), 10, 2)))

RETURN NIL
