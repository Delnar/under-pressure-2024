extends Node

var ticketCodes = [
	"Tickets.  Code: T74GG00-TR",	# Good Job, You should never see this
	"Ticket.  Code: T74JS01-TR",		# Joshua Smith (1 ticket)
	"Tickets.  Code: T74HB02-TR",	# Hunter Bower (2 tickets)
	"Tickets.  Code: T74HW03-TR",	# Heather Wheaton (3 tickets)
	"Tickets.  Code: T74PB04-TR",	# Pastor Becker (4 Tickets)
	"Tickets.  Code: T74DB05-TR",	# Drew Brock (5 Tickets)
	"Tickets.  Code: T74SM06-TR",	# Seth Martinez (6 Tickets)
	"Tickets.  Code: T74JE07-TR",	# James Evans (7 Tickets)
	"Tickets.  Code: T74PJ08-TR",	# Pastor Johnson (8 Tickets)
	"Tickets.  Code: T74PN09-TR",	# Pete Navaro (9 Tickets)
	"Tickets.  Code: T74CM10-TR",	# Church Members (10 Tickets)
	"Tickets.  Code: T74TC11-TR",	# Toney Casados (11 Tickets)
	"Tickets.  Code: T74MM12-TR",	# Mark Mariov (12 Tickets)
]

@onready var ticketCountNode: Label = get_node("/root/Main/Node2D/TicketCount")
@onready var ticketTextNode: Label = get_node("/root/Main/Node2D/TicketText")
@onready var restartButton: TextureButton = get_node("/root/Main/Node2D/RestartButton")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var TicketCount = TicketManager.GetTickets()
	ticketCountNode.text = str(TicketCount)
	ticketTextNode.text = ticketCodes[TicketCount]
	if TicketManager.remaining_tries <= 0:
		restartButton.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
