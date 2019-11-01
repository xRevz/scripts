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
        echo "Diretorio /tmp/erroatm existe, avançando..."
else echo "Criando diretorio, aguarde..."
       mkdir /var/erroatm
fi

#Dando permissão para acesso ao diretorio criado para o script enviar os erros
chmod 755 /var/erroatm

#Modificando o dono do diretorio criado
chown zabbix /var/erroatm/

#as variaveis aX foram declaradas com intuito de facilitar a compreeensão do codigo elas apenas mostram o caminho de onde será criado o arquivo
###############Finalizado as strings que contem falha em Canais indo do 1######################################################
a0=/var/erroatm/falhageral.log
a1=/var/erroatm/falhac1.log
a2=/var/erroatm/falhac2.log
a3=/var/erroatm/falhac3.log
a4=/var/erroatm/falhac4.log

if [ -e "$a0" ]; then
	echo "Arquivo falhageral.log já existe, avançando..."
else echo "Criando arquivo falhageral.log, aguarde..."
	touch /var/erroatm/falhageral.log
fi

if [ -e "$a1" ]; then
	echo "Arquivo falhac1.log já existe, avançando..."
else echo "Criando arquivo falhac1.log,aguarde..."
	touch /var/erroatm/falhac1.log
fi

if [ -e "$a2" ]; then
	echo "Arquivo falhac2.log já existe, avançando..."
else echo "Criando arquivo falhac2.log,aguarde..."
	touch /var/erroatm/falhac2.log
fi

if [ -e "$a3" ]; then
	echo "Arquivo falhac3.log já existe, avançando..."
else echo "Criando arquivo falhac3.log,aguarde..."
	touch /var/erroatm/falhac3.log
fi

if [ -e "$a4" ]; then
	echo "Arquivo falhac4.log já existe, avançando..."
else echo "Criando arquivo falhac4.log,aguarde..."
	touch /var/erroatm/falhac4.log
fi
######################################################Finalizado as strings que contem falha em Canais indo do 1-4######################################################

###################################Strings que contem as strings erro######################################################
a5=/var/erroatm/erroleitura.log
a6=/var/erroatm/erroncatalogado.log
a7=/var/erroatm/errongeral.log

if [ -e "$a5" ]; then
	echo "Arquivo erroleitura.log já existe, avançando..."
else echo "Criando o arquivo erroleitura.log, aguarde."
	touch /var/erroatm/erroleitura.log
fi

if [ -e "$a6" ]; then
	echo "Arquivo erroncatalogado.log já existe, avançando..."
else echo "Criando o arquivo erroncatalogado.log, aguarde."
	touch /var/erroatm/erroncatalogado.log
fi

if [ -e "$a7" ]; then
	echo "Arquivo errongeral.log já existe, avançando..."
else echo "Criando o arquivo errongeral.log, aguarde."
	touch /var/erroatm/errongeral.log
fi
######################################################Finalizando as strings que contem erros######################################################

######################################################Strings com cedula######################################################
a8=/var/erroatm/cedulan1.log
a9=/var/erroatm/cedulan2.log
a10=/var/erroatm/cedulan3.log
a11=/var/erroatm/cedulan4.log
a12=/var/erroatm/cedulan5.log
a13=/var/erroatm/cedulap1.log

if [ -e "$a8" ]; then
	echo "Arquivo cedulan1.log já existe, avançando..."
else echo "Criando o arquivo cedulan1.log, aguarde."
	touch /var/erroatm/cedulan1.log
fi

if [ -e "$a9" ]; then
	echo "Arquivo cedulan2.log já existe, avançando..."
else echo "Criando o arquivo cedulan2.log, aguarde."
	touch /var/erroatm/cedulan2.log
fi

if [ -e "$a10" ]; then
	echo "Arquivo cedulan3.log já existe, avançando..."
else echo "Criando o arquivo cedulan3.log, aguarde."
	touch /var/erroatm/cedulan3.log
fi

if [ -e "$a11" ]; then
	echo "Arquivo cedulan4.log já existe, avançando..."
else echo "Criando o arquivo cedulan4.log, aguarde."
	touch /var/erroatm/cedulan4.log
fi

if [ -e "$a12" ]; then
	echo "Arquivo cedulan5.log já existe, avançando..."
else echo "Criando o arquivo cedulan5.log, aguarde."
	touch /var/erroatm/cedulan5.log
fi

if [ -e "$a13" ]; then
	echo "Arquivo cedulap1.log já existe, avançando..."
else echo "Criando o arquivo cedulap1.log, aguarde."
	touch /var/erroatm/cedulap1.log
fi
#######################################################Finalizando Strings com cedula######################################################

#######################################################Strings com papel######################################################
a14=/var/erroatm/papelsem.log
a15=/var/erroatm/papelpouco.log
a16=/var/erroatm/papelpreso.log
a17=/var/erroatm/papelverif.log
a18=/var/erroatm/papelatol.log
a19=/var/erroatm/papelatolpre.log
a20=/var/erroatm/papelncp.log
a21=/var/erroatm/papelncb1.log
a22=/var/erroatm/papelncb2.log

if  [ -e "$a14" ]; then
	echo "Arquivo papelsem.log já existe, avançando..."
else echo "Criando o arquivo papelsem.log, aguarde." 
	touch /var/erroatm/papelsem.log
fi

if  [ -e "$a15" ]; then
	echo "Arquivo papelpouco.log já existe, avançando..."
else echo "Criando o arquivo papelpouco.log, aguarde." 
	touch /var/erroatm/papelpouco.log
fi

if  [ -e "$a16" ]; then
	echo "Arquivo papelpreso.log já existe, avançando..."
else echo "Criando o arquivo papelpreso.log, aguarde." 
	touch /var/erroatm/papelpreso.log
fi

if  [ -e "$a17" ]; then
	echo "Arquivo papelverif.log já existe, avançando..."
else echo "Criando o arquivo papelverif.log, aguarde." 
	touch /var/erroatm/papelverif.log
fi

if  [ -e "$a18" ]; then
	echo "Arquivo papelatol.log já existe, avançando..."
else echo "Criando o arquivo papelatol.log, aguarde." 
	touch /var/erroatm/papelatol.log
fi

if  [ -e "$a19" ]; then
	echo "Arquivo papelatolpre.log já existe, avançando..."
else echo "Criando o arquivo papelatolpre.log, aguarde." 
	touch /var/erroatm/papelatolpre.log
fi

if  [ -e "$a20" ]; then
	echo "Arquivo papelncp.log já existe, avançando..."
else echo "Criando o arquivo papelncp.log, aguarde." 
	touch /var/erroatm/papelncp.log
fi

if  [ -e "$a21" ]; then
	echo "Arquivo papelncb1.log já existe, avançando..."
else echo "Criando o arquivo papelncb1.log, aguarde." 
	touch /var/erroatm/papelncb1.log
fi

if  [ -e "$a22" ]; then
	echo "Arquivo papelncb2.log já existe, avançando..."
else echo "Criando o arquivo papelncb2.log, aguarde." 
	touch /var/erroatm/papelncb2.log
fi
#######################################################Finalizando Strings com cedula######################################################

#######################################################Finalizando Strings com cedula######################################################
a23=/var/erroatm/dispositivo1025.log
a24=/var/erroatm/dispositivo.log

if [ -e "$a23" ]; then 
	echo "Arquivo dispositivo1025.log já existe, avançando..."
else echo "Criando Dispositivo1025.log, aguarde."
	touch /var/erroatm/dispositivo1025.log
fi

if [ -e "$a24" ]; then 
	echo "Arquivo dispositivo.log já existe, avançando..."
else echo "Criando Dispositivo.log, aguarde."
	touch /var/erroatm/dispositivo.log
fi
#######################################################Finalizando Strings com dispositivo######################################################

#######################################################Finalizando Strings com depositario######################################################
a=/var/erroatm/depositario.log
if [ -e "$a6" ]; then
	echo "Arquivo depositario.log já existe, avançando..."
else echo "Criando depositario.log, aguarde."
	touch /var/erroatm/depositario.log
fi
#######################################################Finalizando Strings com dispositivo######################################################

#Aqui acontece a comparação 
#Se hora do erro for  menor que a hora atual e aquele arquivo já tiver sido lido pelo zabbix ele é ignorado ele insere o caracter 
# e pula para a proxima linha
#Zabbix irá comparar essa variavel com a hora atual do erro, assim ele usará essa variavel com o intuito apenas de comparação para saber se o erro deverá ser descartado na leitura ou não
b1=`date +'%H:%M:%S'`
b2=`tail -n1 $final | awk '{print $1}'`
if [ "$b1" = "$b2" ]; then
    echo "Erro ou Falha já identificados, saltando para proxima linha"
#else echo "erro não identificado"
fi

#Strings coletadas e enviadas aos seus respectivos caminhos
#Strings com falha
#Mapeamento -> Falha na alimentação de cedulas do canal 1 ----> Valor para mapeamento 1
#Mapeamento -> Falha na alimentação de cedulas do canal 2 ----> Valor para mapeamento 2
#Mapeamento -> Falha na alimentação de cedulas do canal 3 ----> Valor para mapeamento 3
#Mapeamento -> Falha na alimentação de cedulas do canal 4 ----> Valor para mapeamento 4
grep -B 2 "falha geral" $final > /var/erroatm/falhageral.log
grep -B 2 "falha na alimentacao de cedulas do canal 1" $final > /var/erroatm/falhac1.log
grep -B 2 "falha na alimentacao de cedulas do canal 2" $final > /var/erroatm/falhac2.log
grep -B 2 "falha na alimentacao de cedulas do canal 3" $final > /var/erroatm/falhac3.log
grep -B 2 "falha na alimentacao de cedulas do canal 4" $final > /var/erroatm/falhac4.log

#Strings com erro
#Mapeamento -> Erro de leitura ----> Valor para mapeamento 5
#Mapeamento -> Erro geral no hadrware ----> Valor para mapeamento 6
grep -B 2 "erro de leitura" $final > /var/erroatm/erroleitura.log
grep -B 2 "erro nao catalogado" $final > /var/erroatm/erroncatalogado.log
grep -B 2 "erro geral no hardware" $final > /var/erroatm/errongeral.log

#String com cedula
#Mapeamento -> cedula não solicitada no canal 1 (Chamar assistencia tecnica) ----> Valor para mapeamento 7
#Mapeamento -> cedula não solicitada no canal 2 (Chamar assistencia tecnica) ----> Valor para mapeamento 8
#Mapeamento -> cedula não solicitada no canal 3 (Chamar assistencia tecnica) ----> Valor para mapeamento 9
#Mapeamento -> cedula não solicitada no canal 4 (Chamar assistencia tecnica) ----> Valor para mapeamento 10
#Mapeamento -> cedula não solicitada no canal 5 (Chamar assistencia tecnica) ----> Valor para mapeamento 11
grep -B 2 "cedula nao solicitada no canal 1" $final > /var/erroatm/cedulan1.log
grep -B 2 "cedula nao solicitada no canal 2" $final > /var/erroatm/cedulan2.log
grep -B 2 "cedula nao solicitada no canal 3" $final > /var/erroatm/cedulan3.log
grep -B 2 "cedula nao solicitada no canal 4" $final > /var/erroatm/cedulan4.log
grep -B 2 "cedula nao solicitada no canal 5" $final > /var/erroatm/cedulan5.log
grep -B 2 "nao e possivel efetuar novo pagamento, existem cedulas na balanca" $final > /var/erroatm/cedulap1.log

#String com papel
#Mapeamento -> Sem papel na impressora de comprovantes ----> Valor para mapeamento 12
#Mapeamento -> Pouco papel impressora de comprovantes ----> Valor para mapeamento 13
#Mapeamento -> Papel preso na impressora de coprovantes ----> Valor para mapeamento 14 
#Mapeamento -> Problemas com Papel atolado ----> Valor para mapeamento 15
#Mapeamento -> Papel atolado na impressora de cheques ----> Valor para mapeamento 16
#Mapeamento -> Papel atolado no percuror da impressora de cheques ----> Valor para mapeamento 17
#Mapeamento -> Folha atolada no presenter da impressora de cheques ----> Valor para mapeamento 18
#Mapeamento -> Sem papel na bandeja 1 (Aliemntar) ----> Valor para mapeamento 19
#Mapeamento -> Sem papel na bandeja 2 (Aliemntar) ----> Valor para mapeamento 20
grep -B 2 "sem papel" $final > /var/erroatm/papelsem.log 
grep -B 2 "pouco papel" $final > /var/erroatm/papelpouco.log  
grep -B 2 "papel preso" $final > /var/erroatm/papelpreso.log 
grep -B 2 "verificar o papel da impressora" $final > /var/erroatm/papelverif.log 
grep -B 2 "atolamento de papel na impressora" $final > /var/erroatm/papelatol.log
grep -B 2 "papel atolado no percurso do presenter" $final > /var/erroatm/papelatolpre.log 
grep -B 2 "folha impressa nao chegou no presenter" $final > /var/erroatm/papelncp.log
grep -B 2 "sem papel/falha alimentacao papel bandeja 1" $final > /var/erroatm/papelncb1.log 
grep -B 2 "sem papel/falha alimentacao papel bandeja 2" $final > /var/erroatm/papelncb2.log 

#String com 1025
#Mapeamento -> dispositivo nao esta pronto ----> Valor para mapeamento 21
#Mapeamento  -> 1025 dispositivo nao esta pronto ----> Valor para mapeamento 22
grep -B 2 "1025 dispositivo nao esta pronto" $final > /var/erroatm/dispositivo1025.log
grep -B 2 "dispositivo nao esta pronto" $final > /var/erroatm/dispositivo.log

#String com Depositario
#Mapeamento -> ausente   ----> Valor para mapeamento 23
grep -B 2 "Caixa de deposito nao esta pronta" $final > /var/erroatm/depositario.log
