#!/bin/bash

proxima=primeira

#loop
while :
do
 
     case "$proxima" in 
	     primeira) 
		         proxima=idade
				 nome=$( dialog --stdout --title 'Cadastro' --inputbox 'Informe o nome:' 0 0 )
				 ;;
		    idade)
			      proxima=tel
				  anterior=primeira
				  idade=$( dialog --stdout --title 'Cadastro' --inputbox 'Informe a idade:' 0 0 )
				  ;;
		      tel)
			      proxima=fim
				  anterior=idade				  
				  tel=$( dialog --stdout --title 'Cadastro' --inputbox 'Informe o telefone:' 0 0 )                 

if [ -z "$nome" ] && [ -z "$idade" ] && [ -z "$tel" ]
then
dialog  --title 'Cadastro' --msgbox "Você não preencheu os campos" 0 0
else 
mysql --user=root --password=root crud <<EOF
INSERT INTO client (nome, idade, telefone) values ('$nome', '$idade', '$tel');
EOF
fi
				  ;;
		      fim)			   
              dialog --msgbox 'Obrigado!' 0 0
			  dialog --yesno 'Deseja continuar?' 0 0
			  if [ $? -eq 1 ] 
			  then
			     break
			  else
			      proxima=primeira
			  fi
			  ;;
				*)
			  dialog --title 'Desculpe' --msgbox 'Não conheço esta opção' 0 0 
			  echo "Programa abortado..."
			  sleep 3
			  exit
	 esac
		
	 retorno=$?
	 [ $retorno -eq 1 ] && proxima=$anterior
	 [ $retorno -eq 255 ] && break
	
done

