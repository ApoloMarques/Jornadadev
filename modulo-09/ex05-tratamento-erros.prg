/*
    Jornada DEV START
    Modulo 09 - Exercicio 05
    Tratamento de erros com BEGIN SEQUENCE / RECOVER
*/

FUNCTION Main()

   LOCAL nA    := 10
   LOCAL nB    := 0
   LOCAL nRes
   LOCAL oErro

   CLS

   ? "============================================"
   ? " MODULO 09 - EXERCICIO 05"
   ? " TRATAMENTO DE ERROS"
   ? "============================================"
   ?

   BEGIN SEQUENCE

      ? "Tentando dividir 10 por 0..."
      ?

      /*
         Nesta versao do Harbour, a divisao por zero
         retorna 0 em vez de gerar automaticamente
         uma excecao.

         Por isso, a condicao e identificada e um
         objeto de erro e criado propositalmente.
      */

      IF nB == 0

         oErro := ErrorNew()
         oErro:Description := "Divisao por zero"

         BREAK oErro

      ENDIF

      nRes := nA / nB

      ? "Resultado:", nRes

   RECOVER USING oErro

      ? "Erro capturado: " + oErro:Description

   END SEQUENCE

   ?
   ? "O programa continua de pe!"
   ?
   ? "Fim da execucao."

   Inkey(0)

RETURN NIL