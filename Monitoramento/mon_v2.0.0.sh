#!/bin/bash

#desabilita o envio
unset MAILCHECK

#geração do caminho onde será criado o arquivo de log do dia.
date +'%d-%m-%Y'.log > /tmp/log.txt
sed -i 's/^/erros_/' /tmp/log.txt
file=$(cat /tmp/log.txt)
way=/home/sisbr/atm/traceSATM/erros/
final="$way$file"
fileErro=/var/erroatm

#Zabbix irá comparar essa variavel com a hora atual do erro, assim ele usará essa variavel com o intuito apenas de comparação
b1=`date +'%H:%M:%S'`
#echo $b1

#Verifica se o diretorio /var/erroatm existe, se não existir ele faz a criação do mesmo
if [ -e "$fileErro" ]; then
        echo "Diretorio /tmp/erroATM existe, avançando..."
else echo "Criando diretorio, aguarde..."
       mkdir /var/erroatm
fi
#sleep 4

#Dando permissão para acesso ao diretorio criado para o script
#Enviar os erros
chmod 755 /var/erroatm

#Modificando o dono do diretorio criado
chown zabbix /var/erroatm/

#as variaveis aX foram declaradas com intuito de facilitar a compreeensão e limpeza do codigo
#elas apenas mostram o caminho de onde será criado o arquivo

a1=/var/erroatm/erro.log
if [ -e "$a1" ]; then
	echo "Arquivo erro.log já existe, avançando..."
else echo "Criando arquivo erro.log,aguarde..."
	touch /var/erroatm/erro.log
fi

a2=/var/erroatm/falha.log
if [ -e "$a2" ]; then
	echo "Arquivo falha.log já existe, avançando..."
else echo "Criando o arquivo falha.log, aguarde."
	touch /var/erroatm/falha.log
fi

a3=/var/erroatm/DispositivoAusente.log
if [ -e "$a3" ]; then
	echo "Arquivo DispositivoAusente.log já existe, avançando..."
else echo "Criando o arquivo DispositivoAusente.log, aguarde."
	touch /var/erroatm/DispositivoAusente.log
fi

a4=/var/erroatm/PoucoPapel.log
if  [ -e "$a4" ]; then
	echo "Arquivo PoucoPapel.log já existe, avançando..."
else echo "Criando o arquivo poucoPapel.log, aguarde." 
	touch /var/erroatm/PoucoPapel.log
fi

a5=/var/erroatm/DispositivoNaoEstaPronto.log
if [ -e "$a5" ]; then 
	echo "Arquivo DispositivoNaoEstaPronto.log já existe, avançando..."
else echo "Criando DispositivoNaoEstaPronto.log, aguarde."
	touch /var/erroatm/DispositivoNaoEstaPronto.log
fi

a6=/var/erroatm/PapelAtolado.log
if [ -e "$a6" ]; then
	echo "Arquivo PapelAtolado.log já existe, avançando..."
else echo "Criando PapelAtolado.log, aguarde."
	touch /var/erroatm/PapelAtolado.log
fi

a7=/var/erroatm/CedulaPresaNaBalanca.log
if [ -e "$a7" ]; then
	echo "Arquivo CedulaPresaNaBalanca.log já existe, avançando..."
else echo "Criando arquivo CedulaPresaNaBalanca.log"
	touch /var/erroatm/CedulaPresaNaBalanca.log
fi
#Aqui acontece a comparação 
#Se hora do erro for  menor que a hora atual e aquele arquivo já tiver sido lido pelo zabbix ele é ignorado e pula para a proxima linha
#if [ "$b1" = "date +"%D-%m-%Y"" ]; then
#Strings coletadas e enviadas aos seus respectivos caminhos
grep -B 2 "erro" $final > /var/erroatm/erro.log
grep -B 2 "falha" $final > /var/erroatm/falha.log
grep -B 2 "ausente" $final > /var/erroatm/DispositivoAusente.log
grep -B 2 "pouco papel" $final > /var/erroatm/PoucoPapel.log
grep -B 2 "dispositivo nao esta pronto" $final > /var/erroatm/DispositivoNaoEstaPronto.log
grep -B 2 "tampa duplex aberta/gaveta aberta" $final > /var/erroatm/gavetaAberta.log
grep -B 2 "papel atolado no percurso do presenter" $final > /var/erroatm/PapelAtolado.log
grep -B 2 "nÃƒÂ£o e possivel efetuar novo pagamento, existem cÃƒÂ©dulas na balanÃƒÂ§a" $final > /var/erroatm/CedulaPresaNaBalanca.log
