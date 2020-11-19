extends OptionButton

var options = {
	"dolnośląskie": 0,
	"kujawsko-pomorskie": 1,
	"lubelskie": 2,
	"lubuskie": 3,
	"łódzkie": 4,
	"małopolskie": 5,
	"mazowieckie": 6,
	"opolskie": 7,
	"podkarpackie": 8,
	"podlaskie": 9,
	"pomorksie": 10,
	"śląskie": 11,
	"świętokrzyskie": 12,
	"warmińsko-mazurskie": 13,
	"wielkopolskie": 14,
	"zachodniopomorskie": 15
}

func _ready():
	var optionList = options.keys()
	
	for option in optionList:
		add_item(option, options[option])
	
	selected = 4


