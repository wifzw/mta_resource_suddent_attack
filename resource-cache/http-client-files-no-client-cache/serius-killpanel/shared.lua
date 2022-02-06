
ayarlar = {
    client = {
      ["paneladi"] = "Suddent Attack - Kill Panel", -- título do painel
      ["tus"] = "F6",  -- botão de abertura do painel
	  ["beklemeyazi"] = "CARREGANDO PONTUAÇÕES, AGUARDE", -- o texto no meio quando o painel é aberto,
      ["blurdurum"] = true,-- O desfoque que ocorre na tela não aparecerá se você fizer falso.
      ["barrenk"] = "1a1919",
      ["barcizgirenk"] = "000000",
      ["panelbaslikrenk"] = "292929",
      ["panelbaslikcizgirenk"] = "989898",
      ["listekenarrenk"] = "333333",
      renkler = {
        --painel de classificação
        ["buton1"] = "3089b3", 
        ["buton2"] = "cc0000",
        --painel de mudanças
        ["buton3"] = "38ebbb", 
        ["buton4"] = "cf254a",   
      },
      yazilar = {
        --painel de mudanças
        ["listecolnm1"] = "PEDIDO",
        ["listecolnm2"] = "  NICK",
        ["listecolnm3"] = "    KILL",
        ["listecolnm4"] = "  DEATH",
        ["listecolnm5"] = " HS",
        ["listecolnm6"] = "K/D",
        ["buton1"] = "Fazer mudanças",
        ["buton2"] = "Fechar Painel",
        --alterar painel
        ["label1"] = " KILL TOTAL:",
        ["label2"] = " DEATH TOTAL:",
        ["label3"] = " HS TOTAL:",
        ["buton3"] = "Atualizar",
        ["buton4"] = "Fechar Painel",
      },
    },
    server = {
        ["veriguncelle"] = false,-- Se o painel estiver aberto quando você matar um homem, os dados serão atualizados.
        ["oldurmepuan"] = 1, -- Adiciona 1 ponto ao número de pessoas que você mata, à sua pontuação atual, por exemplo; 1000 torna-se 1001.
        ["hspuan"] = 1, -- Adiciona 1 ponto ao número de pessoas que você mata por hs à sua pontuação atual, por exemplo; 1000 torna-se 1001.
        ["olumpuan"] = 1, -- Cada vez que você morre, a morte soma 1 ponto, por exemplo; 1000 torna-se 1001.
        ["veritabanıadi"] = "database",
        ["aclgrup"] = {"Console","Wifz"}-- pessoas que podem alterar a pontuação dos jogadores escolhendo na lista.
    },
    mesajlar = {
        ["veridegistirdi"] = "#d44a4a%s #999999'adlı oyuncunun [#999999Öldürme Puanı:#1b8af2%s,#999999,Ölüm Puanı:#d41717%s,#999999,HS Puanı:#3dd167%s#999999]", -- cai na tela/chat da pessoa que alterou os dados.
        ["veridegisti"] = "#d44a4a%s #999999'adlı yetkili senin [#999999Öldürme Puanını:#1b8af2%s,#999999,Ölüm Puanını:#d41717%s #999999,HS Puanını:#3dd167%s #999999]", -- cai na tela/chat da pessoa que alterou os dados.
        ["mesaj1"] = "#d44a4aOlarak mudou!", -- cai no chat da pessoa que mudou 
        ["mesaj2"] = "#d44a4aOlarak mudou!", -- cai no chat do jogador alterado
        ["mesaj3"] = "[!] #ffffffLütfen escolha um jogador da lista!", -- Se ele pressionar o botão fazer alterações sem selecionar um jogador da lista, ele estará no chat da pessoa que clicou.
    },
}
--Se você quiser desligar seu hud ou radar ou qualquer outra coisa na tela, digite seu código na função abaixo.
function ekrandaolanlariKapat(durum)
    if durum == true then  -- panel açıldığında
        --eventos a acontecer
        --ex: export["hudum"]:visible(false) / desabilitamos nossa borda
        --print("AÇILDI")
        showPlayerHudComponent("all",false) 
    else--panel kapatılınca
        showPlayerHudComponent("all",true)
        --gerçekleşcek olaylar
        --ex: exports["hudum"]:visible(false) / ativamos nossa fronteira
        --print("Kapatıldı")
    end
end
function convertNumber ( number )  
    local formatted = number  
     while true do      
     formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
      if ( k==0 ) then      
            break   
        end  
    end  
    return formatted
end