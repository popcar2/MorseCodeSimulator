extends Node
func morse_to_text(text: String):
	var split_text: PackedStringArray = text.split(' ')
	var translated_text: String = ''
	for letter in split_text:
		if letter.contains('|'):
			letter = letter.replace('|', '')
			translated_text += ' '
		
		match letter:
			'ET': translated_text += 'A'
			'TEEE': translated_text += 'B'
			'TETE': translated_text += 'C'
			'TEE': translated_text += 'D'
			'E': translated_text += 'E'
			'EETE': translated_text += 'F'
			'TTE': translated_text += 'G'
			'EEEE': translated_text += 'H'
			'EE': translated_text += 'I'
			'ETTT': translated_text += 'J'
			'TET': translated_text += 'K'
			'ETEE': translated_text += 'L'
			'TT': translated_text += 'M'
			'TE': translated_text += 'N'
			'TTT': translated_text += 'O'
			'ETTE': translated_text += 'P'
			'TTET': translated_text += 'Q'
			'ETE': translated_text += 'R'
			'EEE': translated_text += 'S'
			'T': translated_text += 'T'
			'EET': translated_text += 'U'
			'EEET': translated_text += 'V'
			'ETT': translated_text += 'W'
			'TEET': translated_text += 'X'
			'TETT': translated_text += 'Y'
			'TTEE': translated_text += 'Z'
			
			'ETTTT': translated_text += '1'
			'EETTT': translated_text += '2'
			'EEETT': translated_text += '3'
			'EEEET': translated_text += '4'
			'EEEEE': translated_text += '5'
			'TEEEE': translated_text += '6'
			'TTEEE': translated_text += '7'
			'TTTEE': translated_text += '8'
			'TTTTE': translated_text += '9'
			'TTTTT': translated_text += '0'
			
			'ETETET': translated_text += '.'
			'TTEETT': translated_text += ','
			'EETTEE': translated_text += '?'
			'TTTE': translated_text += '!'
			'TTTEEE': translated_text += ':'
			'TETETE': translated_text += ';'
			'ETETE': translated_text += '+'
			'TEEEET': translated_text += '-'
			'TEEET': translated_text += '='
			'ETTTTE': translated_text += "'"
			'TEETE': translated_text += '/'
			'ETEETE': translated_text += '"'
			'TETTE': translated_text += '('
			'TETTET': translated_text += ')'
			
			_: translated_text += '☐'
	
	return translated_text

func highlight_specific_word(text: String, idx: int):
	var split_text: PackedStringArray = text.split(' ')
	var has_slash = split_text[idx].begins_with('|')
	
	if has_slash:
		split_text[idx] = split_text[idx].trim_prefix('|')
	
	split_text[idx] = '[color=red]' + split_text[idx] + '[/color]'
	
	if has_slash:
		split_text[idx] = '|' + split_text[idx]
	
	return ' '.join(split_text)

func highlight_specific_letter(text: String, idx: int):
	if idx < 0:
		text = text.insert(text.length() - idx - 2, "[color=red]")
		text = text.insert(text.length() - idx + 1, '[/color]')
	else:
		text = text.insert(idx, "[color=red]")
		text = text.insert(text.find(']', idx) + 2, '[/color]')
	return text

func strip_bbcode(text: String):
	var regex = RegEx.new()
	regex.compile("\\[.*?\\]")
	return regex.sub(text, "", true)
