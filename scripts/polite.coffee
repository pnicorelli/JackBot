# Description
#  Just to be polite....

module.exports = (robot) ->

	robot.respond /(.*)ciao(.*)/i, (msg) ->
		msg.send "Hey, ciao #{msg.message.user.name}!"

	robot.respond /aiuto/i, (msg) ->
		msg.send "Tu dici questo, io ti rispondo questo:\n"
		msg.send " - *classifica degli utenti*: chi ha creato piu' memo/anime"
		msg.send " - *usersStats*: le statistiche degli utenti"
		msg.send " - *animaeStats*: le statistiche delle anime"
		msg.send " - *ultimi n iscritti* con n compreso da 1-50"
		msg.send " - *ultime n anime* con n compreso da 1-50"
		msg.send " - *memo per categoria* statistiche sui memo"
		msg.send " - *memo per tipo* statistiche sui memo"
