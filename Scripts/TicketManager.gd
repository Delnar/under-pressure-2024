extends Node

var ticket_options: Array = []
var max_tickets: int = 0
var remaining_tries: int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rt = DataManager.ReadData("remaining_tries", "3")
	remaining_tries = int(rt)
	CalculateTicketOptions()
	

func CalculateTicketOptions():
	var t = Time.get_time_dict_from_system()
	
	var hour = t.hour
	if hour > 12:
		hour = hour - 12
	
	if hour <= 5:
		CalculateTicketOptions_before_5()
		return
	if hour <= 10:
		CalculateTicketOptions_before_10()
		return
	CalculateTicketOptions_util_12()
		
	
func CalculateTicketOptions_before_5():
	var options = range(8)
	var order: Array = range(4)    # 0 to 4 (so add +1 when using the ticket couter)
	
	for x in range(len(order)):
		for n in options:
			ticket_options.append(order[x]+1)
			
	max_tickets = 6

func CalculateTicketOptions_before_10():
	var options = range(4)
	var order: Array = range(9)    # 0 to 9 (so add +1 when using the ticket couter)

	for x in range(len(order)):
		for n in options:
			ticket_options.append(order[x]+1)

	max_tickets = 11

func CalculateTicketOptions_util_12():
	var options = range(4)
	var order: Array = range(10)    # 0 to 10 (so add +1 when using the ticket couter)

	for x in range(len(order)):
		for n in options:
			ticket_options.append(order[x]+1)
	
	ticket_options.append(12)
	ticket_options.append(12)
	
	max_tickets = 12
	
func UpdateOdds():
	var minValue = ticket_options.min()
	var index = ticket_options.find(minValue)
	ticket_options.append(max_tickets)
	ticket_options.remove_at(index)
	
	print_debug("Updating Odds")	
	
func GetTickets():
	var ret = ticket_options.pick_random()
	remaining_tries = remaining_tries - 1
	DataManager.WriteData("remaining_tries", str(remaining_tries))
	DataManager.WriteData("tickets_won", str(ret))
	return ret
