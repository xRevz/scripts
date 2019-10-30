#!/bin/bash

#desabilita o envio de mails para o usuario que roda o script
unset MAILCHECK

#geração do caminho onde será criado o arquivo de log do dia.
date +'%d-%m-%Y'.log > /tmp/log.txt
sed -i 's/^/erros_/' /tmp/log.txt
file=$(cat /tmp/log.txt)
way=/home/sisbr/atm/traceSATM/erros/
final="$way$file"
fileErro=/var/erroatm

#tratamento de strings sem UTF-8
sed 's/nÃƒÂ£o/nao/g' $final
sed 's/nÃ£o/nao/g' $final
sed 's/cÃƒÂ©dulas/cedulas/g' $final
sed 's/cÃ©dulas/cedulas/g' $final
sed 's/balanÃƒÂ§a/balança/g' $final
sed 's/balanÃ§a/balanca/g' $final
sed 's/invÃ¡lido/invalido/g' $final
sed 's/alimentaÃ§Ã£o/alimentacao/g' $final
sed 's/depÃ³sito/deposito/g' $final
sed 's/CÃ³digo/codigo/g' $final

#Verifica se o diretorio /var/erroatm existe, se não existir ele faz a criação do mesmo
if [ -e "$fileErro" ]; then
        echo "Diretorio /tmp/erroATM existe, avançando..."
else echo "Criando diretorio, aguarde..."
       mkdir /var/erroatm
fi

#Dando permissão para acesso ao diretorio criado para o script enviar os erros
chmod 755 /var/erroatm

#Modificando o dono do diretorio criado
chown zabbix /var/erroatm/

#as variaveis aX foram declaradas com intuito de facilitar a compreeensão do codigo elas apenas mostram o caminho de onde será criado o arquivo
a1=/var/erroatm/falha.log
if [ -e "$a1" ]; then
	echo "Arquivo falha.log já existe, avançando..."
else echo "Criando arquivo falha.log,aguarde..."
	touch /var/erroatm/falha.log
fi

a2=/var/erroatm/erro.log
if [ -e "$a2" ]; then
	echo "Arquivo erro.log já existe, avançando..."
else echo "Criando o arquivo falha.log, aguarde."
	touch /var/erroatm/falha.log
fi

a3=/var/erroatm/cedula.log
if [ -e "$a3" ]; then
	echo "Arquivo cedula.log já existe, avançando..."
else echo "Criando o arquivo cedula.log, aguarde."
	touch /var/erroatm/cedula.log
fi

a4=/var/erroatm/papel.log
if  [ -e "$a4" ]; then
	echo "Arquivo papel.log já existe, avançando..."
else echo "Criando o arquivo papel.log, aguarde." 
	touch /var/erroatm/papel.log
fi

a5=/var/erroatm/dispositivo.log
if [ -e "$a5" ]; then 
	echo "Arquivo dispositivo.log já existe, avançando..."
else echo "Criando Dispositivo.log, aguarde."
	touch /var/erroatm/dispositivo.log
fi

a6=/var/erroatm/depositario.log
if [ -e "$a6" ]; then
	echo "Arquivo depositario.log já existe, avançando..."
else echo "Criando depositario.log, aguarde."
	touch /var/erroatm/depositario.log
fi

#Aqui acontece a comparação 
#Se hora do erro for  menor que a hora atual e aquele arquivo já tiver sido lido pelo zabbix ele é ignorado ele insere o caracter # e pula para a proxima linha
#Zabbix irá comparar essa variavel com a hora atual do erro, assim ele usará essa variavel com o intuito apenas de comparação para saber se o erro deverá ser descartado na leitura ou não
b1=`date +'%H:%M:%S'`
b2=`tail -n1 $final | awk '{print $1}'`
if [ "$b1" -eq "$b2" ]; then
    echo "Erro já identificado, saltando para proxima linha"

#Strings coletadas e enviadas aos seus respectivos caminhos
#Strings com falha
#Mapeamento -> Falha na alimentação de cedulas do canal 1 ----> Valor para mapeamento 1
#Mapeamento -> Falha na alimentação de cedulas do canal 2 ----> Valor para mapeamento 2
#Mapeamento -> Falha na alimentação de cedulas do canal 3 ----> Valor para mapeamento 3
#Mapeamento -> Falha na alimentação de cedulas do canal 4 ----> Valor para mapeamento 4
grep -B 2 "falha geral" $final > /var/erroatm/falha.log
grep -B 2 "falha na alimentacao de cedulas do canal 1" $final > /var/erroatm/falha.log
grep -B 2 "falha na alimentacao de cedulas do canal 2" $final > /var/erroatm/falha.log
grep -B 2 "falha na alimentacao de cedulas do canal 3" $final > /var/erroatm/falha.log
grep -B 2 "falha na alimentacao de cedulas do canal 4" $final > /var/erroatm/falha.log

#Strings com erro
#Mapeamento -> Erro de leitura ----> Valor para mapeamento 5
#Mapeamento -> Erro geral no hadrware ----> Valor para mapeamento 6
#Mapeamento -> Erro nao catalogado ----> Valor para mapeamento 7
grep -B 2 "erro de leitura" $final > /var/erroatm/erro.log
grep -B 2 "erro nao catalogado" $final > /var/erroatm/erro.log
grep -B 2 "erro geral no hardware" $final > /var/erroatm/erro.log
grep -B 2 "erro na conferência da banda cmc7" $final > /var/erroatm/erro.log

#String com cedula
#Mapeamento -> cedula não solicitada no canal 1 (Chamar assistencia tecnica) ----> Valor para mapeamento 8
#Mapeamento -> cedula não solicitada no canal 2 (Chamar assistencia tecnica) ----> Valor para mapeamento 9
#Mapeamento -> cedula não solicitada no canal 3 (Chamar assistencia tecnica) ----> Valor para mapeamento 10
#Mapeamento -> cedula não solicitada no canal 4 (Chamar assistencia tecnica) ----> Valor para mapeamento 11
#Mapeamento -> cedula não solicitada no canal 5 (Chamar assistencia tecnica) ----> Valor para mapeamento 12
grep -B 2 "cedula nao solicitada no canal 1" $final > /var/erroatm/cedula.log
grep -B 2 "cedula nao solicitada no canal 2" $final > /var/erroatm/cedula.log
grep -B 2 "cedula nao solicitada no canal 3" $final > /var/erroatm/cedula.log
grep -B 2 "cedula nao solicitada no canal 4" $final > /var/erroatm/cedula.log
grep -B 2 "cedula nao solicitada no canal 5" $final > /var/erroatm/cedula.log
grep -B 2 "nao e possivel efetuar novo pagamento, existem cedulas na balanca" $final > /var/erroatm/cedula.log

#String com papel
#Mapeamento -> Sem papel na impressora de comprovantes ----> Valor para mapeamento 13
#Mapeamento -> Pouco papel impressora de comprovantes ----> Valor para mapeamento 14
#Mapeamento -> Papel preso na impressora de coprovantes ----> Valor para mapeamento 15 
#Mapeamento -> Problemas com Papel atolado ----> Valor para mapeamento 16
#Mapeamento -> Papel atolado na impressora de cheques ----> Valor para mapeamento 17
#Mapeamento -> Papel atolado no percuror da impressora de cheques ----> Valor para mapeamento 18
#Mapeamento -> Folha atolada no presenter da impressora de cheques ----> Valor para mapeamento 19
#Mapeamento -> Sem papel na bandeja 1 (Aliemntar) ----> Valor para mapeamento 20
#Mapeamento -> Sem papel na bandeja 2 (Aliemntar) ----> Valor para mapeamento 21
grep -B 2 "sem papel" $final > /var/erroatm/papel.log 
grep -B 2 "pouco papel" $final > /var/erroatm/papel.log  
grep -B 2 "papel preso" $final > /var/erroatm/papel.log 
grep -B 2 "verificar o papel da impressora" $final > /var/erroatm/papel.log 
grep -B 2 "atolamento de papel na impressora" $final > /var/erroatm/papel.log
grep -B 2 "papel atolado no percurso do presenter" $final > /var/erroatm/papel.log 
grep -B 2 "folha impressa nao chegou no presenter" $final > /var/erroatm/papel.log
grep -B 2 "sem papel/falha alimentacao papel bandeja 1" $final > /var/erroatm/papel.log 
grep -B 2 "sem papel/falha alimentacao papel bandeja 2" $final > /var/erroatm/papel.log 

#String com 1025
#Mapeamento -> dispositivo nao esta pronto ----> Valor para mapeamento 22
#Mapeamento  -> 1025 dispositivo nao esta pronto ----> Valor para mapeamento 23
grep -B 2 "dispositivo nao esta pronto" $final > /var/erroatm/dispositivo.log
grep -B 2 "1025  dispositivo nao esta pronto" $final > /var/erroatm/papel.log

#String com Depositario
#Mapeamento -> ausente   ----> Valor para mapeamento 24
grep -B 2 "Caixa de deposito nao esta pronta" $final > /var/erroatm/depositario.log