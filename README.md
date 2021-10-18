# asterisk_to_telegram
send call record to telegram after call

Установка на FREEPBX:
# Перейдите в настройках по следующему пути:
Общие настройки -> Дополнительные настройки -> Скрипт обработки записи после вызова -  /road/to/telegram.sh ^{YEAR} ^{MONTH} ^{DAY} ^{TIMESTR} ^{FROMEXTEN} ^{CALLFILENAME} ^{MIXMON_FORMAT} ^{ARG3}
# /road/to/ - укажите путь до скрипта на сервере.
