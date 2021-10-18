#!/bin/bash

token=TELEGRAM_BOT_TOKEN

# Блок входящщих переменных
YEAR=$1
MONTH=$2
DAY=$3

DATETIME=$4
CALLER=$5
CALLING=$8

RECORDNAME=$6
RECORDFORMAT=$7

chat_id=0

# Взвешиваем файл
filesize="$(stat -c %s "/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT")"

# Адресная "книга"
abonent=(\
["9"]="Шлюз" \
["000"]="Диспетчер" \
["100"]="Вещев А.Н." \
["101"]="Аквариум" \
["102"]="Ардашова" \
["103"]="Карнаухов И.Н." \
["104"]="Сычев А.Г." \
["105"]="Машуков И.С." \
["106"]="Шаргунова Т.П." \
["107"]="ЛПС 1" \
["108"]="Козлов А.Н." \
["109"]="Аргат А.Б."
["110"]="Свириденко Н.Н." \
["111"]="Бохон Ю.В." \
["113"]="Омельчук Т.Д." \
["114"]="Михайленко А.П." \
["115"]="Никонов И.С." \
["116"]="Бакуменко А.В." \
["117"]="Борисов Д.А." \
["118"]="Бригадир ОГМ" \
["119"]="ЛПС 2" \
["120"]="Данилова Е.С." \
["121"]="ЛПС 4" \
["122"]="17й пост" \
["123"]="1й пост" \
["124"]="Гараж Либхер" \
["125"]="Замащиков А.В." \
["126"]="8й пост" \
["127"]="Электрики ПП (УПС)" \
["128"]="Веряскин В.Н." \
["129"]="Фролова О.Ю." \
["130"]="Ковалев В.А." \
["131"]="Перовских А.Г." \
["132"]="Мастер ПП(УС)" \
["133"]="Куликова Т.А." \
["134"]="Мастер ПП(УО)" \
["135"]="Бригадир ПП(УО)" \
["136"]="Погодаева С.С." \
["137"]="4AB" \
["138"]="4CD" \
["139"]="Кремкова И.А." \
["140"]="Какаурова Е.А." \
["141"]="Наумченко А.И." \
["142"]="Новикова Д.С." \
["150"]="6 весовая" \
["151"]="Мастер ПП(УПС)" \
["154"]="Бригадир ПП(УПС)" \
["155"]="Слесарь ПП(УПС)" \
["156"]="Литовская В.П." \
["157"]="Оператор 1 ПП(УО)" \
["158"]="Комплектовщик 1 ПП(УО)" \
["159"]="Оператор ПП(УС) 1" \
["160"]="Оператор ПП(УС) 2" \
["161"]="Вершина 4А" \
["162"]="Дежурный АСУТП" \
["163"]="Григорьева Н.С." \
["164"]="Музыка О.В." \
["165"]="Загребнева С.А." \
["166"]="Александрова Т.Б." \
["167"]="Близнюк Т.Ю." \
["168"]="Исаева О.С." \
["169"]="Электрики ПП(УС)" \
["170"]="Лаборатория АСУТП" \
["171"]="Выход 7А" \
["172"]="Скрипченко Э.В." \
["200"]="Тестфон" \
["205"]="Машуков И.С. (моб)" \
["208"]="Козлов А.Н. (моб)" \
["209"]="Аргат А.Б." \
["214"]="Михайленко А.П. (моб)" \
["216"]="Бакуменко А.В. (моб)" \
["218"]="Бригадир ОГМ (моб)" \
["220"]="Данилова Е.С. (моб)" \
["225"]="Замащиков А.В." \
["228"]="Веряскин В.Н. (моб)" \
["230"]="Ковалев В.А. (моб)" \
["231"]="Перовских А.Г. (моб)" \
["232"]="Мастер ПП(УС) (моб)" \
["233"]="Куликова Т.А. (моб)" \
["234"]="Мастер ПП(УО) (моб)" \
["236"]="Погодаева С.С. (моб)" \
["241"]="Наумченко А.И. (моб)" \
["242"]="Новикова Д.С. (моб)" \
["251"]="Мастер ПП(УПС) (моб)" \
["267"]="Близнюк Т.Ю. (моб)" )

# Сортировка

## ПП (УПС)
if [[ "$CALLER" -eq "107" || "$CALLING" -eq "107" ]]\
|| [[ "$CALLER" -eq "108" || "$CALLING" -eq "108" ]]\
|| [[ "$CALLER" -eq "119" || "$CALLING" -eq "119" ]]\
|| [[ "$CALLER" -eq "121" || "$CALLING" -eq "121" ]]\
|| [[ "$CALLER" -eq "127" || "$CALLING" -eq "127" ]]\
|| [[ "$CALLER" -eq "150" || "$CALLING" -eq "150" ]]\
|| [[ "$CALLER" -eq "151"  || "$CALLING" -eq "151" ]]\
|| [[ "$CALLER" -eq "154"  || "$CALLING" -eq "154" ]]\
|| [[ "$CALLER" -eq "155"  || "$CALLING" -eq "155" ]];
	then
  		chat_id="-1001280980046";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
		fi;
fi;

## Диспетчер
if [[ "$CALLER" -eq "000" || "$CALLING" -eq "000" ]];
	then
  		chat_id="-1001263135829";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
			fi;
fi;

## СБЫТ
if [[ "$CALLER" -eq "106" || "$CALLING" -eq "106" ]] \
|| [[ "$CALLER" -eq "166" || "$CALLING" -eq "166" ]] \
|| [[ "$CALLER" -eq "167" || "$CALLING" -eq "167" ]] \
|| [[ "$CALLER" -eq "267" || "$CALLING" -eq "267" ]] \
|| [[ "$CALLER" -eq "165" || "$CALLING" -eq "165" ]] \
|| [[ "$CALLER" -eq "168" || "$CALLING" -eq "168" ]] \
|| [[ "$CALLER" -eq "129" || "$CALLING" -eq "129" ]];
	then
  		chat_id="-1001339387407";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
			fi;
fi;

## ОМТС
if [[ "$CALLER" -eq "110" || "$CALLING" -eq "110" ]]\
|| [[ "$CALLER" -eq "164" || "$CALLING" -eq "164" ]]\
|| [[ "$CALLER" -eq "163" || "$CALLING" -eq "163" ]]\
|| [[ "$CALLER" -eq "156" || "$CALLING" -eq "156" ]];
	then
  		chat_id="-1001467752549";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
			fi;
fi;

## ОИТ
if [[ "$CALLER" -eq "125" || "$CALLING" -eq "125" ]]\
|| [[ "$CALLER" -eq "225" || "$CALLING" -eq "225" ]]\
|| [[ "$CALLER" -eq "128" || "$CALLING" -eq "128" ]]\
|| [[ "$CALLER" -eq "228" || "$CALLING" -eq "228" ]]\
|| [[ "$CALLER" -eq "130" || "$CALLING" -eq "130" ]]\
|| [[ "$CALLER" -eq "230" || "$CALLING" -eq "230" ]]\
|| [[ "$CALLER" -eq "131" || "$CALLING" -eq "131" ]]\
|| [[ "$CALLER" -eq "231" || "$CALLING" -eq "231" ]]\
|| [[ "$CALLER" -eq "133" || "$CALLING" -eq "133" ]]\
|| [[ "$CALLER" -eq "200" || "$CALLING" -eq "200" ]]\
|| [[ "$CALLER" -eq "233" || "$CALLING" -eq "233" ]];
	then
  		chat_id="-1001386480646";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
			fi;
fi;

## ПП (УС)
if [[ "$CALLER" -eq "139" || "$CALLING" -eq "139" ]]\
|| [[ "$CALLER" -eq "132" || "$CALLING" -eq "132" ]]\
|| [[ "$CALLER" -eq "159" || "$CALLING" -eq "159" ]]\
|| [[ "$CALLER" -eq "160" || "$CALLING" -eq "160" ]]\
|| [[ "$CALLER" -eq "135" || "$CALLING" -eq "135" ]]\
|| [[ "$CALLER" -eq "161" || "$CALLING" -eq "161" ]]\
|| [[ "$CALLER" -eq "138" || "$CALLING" -eq "138" ]]\
|| [[ "$CALLER" -eq "137" || "$CALLING" -eq "137" ]]\
|| [[ "$CALLER" -eq "171" || "$CALLING" -eq "171" ]]\
|| [[ "$CALLER" -eq "232" || "$CALLING" -eq "232" ]];
	then
  		chat_id="-1001210372098";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
			fi;
fi;

## СЗА
if [[ "$CALLER" -eq "116" || "$CALLING" -eq "116" ]]\
|| [[ "$CALLER" -eq "216" || "$CALLING" -eq "216" ]]\
|| [[ "$CALLER" -eq "123" || "$CALLING" -eq "123" ]]\
|| [[ "$CALLER" -eq "126" || "$CALLING" -eq "126" ]]\
|| [[ "$CALLER" -eq "122" || "$CALLING" -eq "122" ]];
	then
  		chat_id="-1001371373380";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
			fi;
fi;

## ОП
if [[ "$CALLER" -eq "117" || "$CALLING" -eq "117" ]]\
|| [[ "$CALLER" -eq "140" || "$CALLING" -eq "140" ]]\
|| [[ "$CALLER" -eq "120" || "$CALLING" -eq "120" ]]\
|| [[ "$CALLER" -eq "220" || "$CALLING" -eq "220" ]];
	then
  		chat_id="-1001215811256";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
			fi;
fi;

## СУТПиК
if [[ "$CALLER" -eq "109" || "$CALLING" -eq "109" ]]\
|| [[ "$CALLER" -eq "141" || "$CALLING" -eq "141" ]]\
|| [[ "$CALLER" -eq "142" || "$CALLING" -eq "142" ]]\
|| [[ "$CALLER" -eq "209" || "$CALLING" -eq "209" ]]\
|| [[ "$CALLER" -eq "241" || "$CALLING" -eq "241" ]]\
|| [[ "$CALLER" -eq "242" || "$CALLING" -eq "242" ]];
	then
  		chat_id="-1001411840617";
		if [ "$filesize" != "44" ];
			then
				curl --socks5-basic -s -X POST https://api.telegram.org/bot$token/sendVoice -F chat_id=$chat_id \
				-F voice=@/var/spool/asterisk/monitor/$YEAR/$MONTH/$DAY/$RECORDNAME.$RECORDFORMAT \
				-F caption="Запись разговора ${abonent[$CALLER]} с ${abonent[$CALLING]}"
			fi;
fi;
