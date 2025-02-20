class_name Money extends Resource

var count: int:
	set(value):
		var delta =  value - count
		if delta != 0:
			count = value
			count_changed.emit(value, delta)
signal count_changed(new_value: int, delta: int)

func gain(value: int):
	count += value

func pay(value: int):
	count -= value

func can_pay(value: int) -> bool:
	return count >= value

static func constructor(count: int) -> Money:
	var money = Money.new()
	money.count = count
	return money
