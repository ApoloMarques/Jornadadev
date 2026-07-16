REQUEST HB_CODEPAGE_UTF8

FUNCTION MAIN()
    LOCAL nValor    := 250
    LOCAL nDesconto := 0
    LOCAL nTotal    := 0

    // Configura o terminal para aceitar caracteres UTF8
    hb_cdpSelect("UTF8")

    // Define o valor do desconto baseado na condicao
    if nValor > 100
        nDesconto := nValor * 0.10
    else
        nDesconto := 0
    endif

    // Calcula o total final de forma garantida para ambos os casos
    nTotal := nValor - nDesconto

    // Exibe os resultados na tela usando hb_ntos para converter numero em texto
    if nDesconto > 0
        QOut("O valor do desconto foi de: R$ " + hb_ntos(nDesconto))
        QOut("O valor final com desconto e de: R$ " + hb_ntos(nTotal))
    else
        QOut("Nao houve desconto, o valor total e de: R$ " + hb_ntos(nTotal))
    endif

RETURN NIL