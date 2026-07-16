REQUEST HB_CODEPAGE_PT850

PROCEDURE Main()
   LOCAL cNome   := " Apolo Marques "
   LOCAL cCidade := "SÆo Paulo - SP"
   LOCAL cCurso  := "Harbour/ADVPL"

   HB_CDPSELECT("PT850")

   ? "=============================="
   ? "      FICHA DE APRESENTA€ÇO"
   ? "=============================="
   ? "Nome   : " + cNome
   ? "Cidade : " + cCidade
   ? "Curso  : " + cCurso
   ? "=============================="

RETURN

