extends Node
func morse_to_text(text: String) -> String:
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
			'TETETT': translated_text += '!' #Alternate way of doing !
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
			'ETEEE': translated_text += '&'
			'ETTETE': translated_text += '@'
			
			'EEEEEEEE': translated_text += '␡'
			'': pass # In case of an empty letter, such as when deleting a word
			
			_: translated_text += '#'
	
	return translated_text

func text_to_morse(text: String) -> String:
	var translated_text = ''
	for letter in text.to_upper():
		match letter:
			'A': translated_text += 'ET '
			'B': translated_text += 'TEEE '
			'C': translated_text += 'TETE '
			'D': translated_text += 'TEE '
			'E': translated_text += 'E '
			'F': translated_text += 'EETE '
			'G': translated_text += 'TTE '
			'H': translated_text += 'EEEE '
			'I': translated_text += 'EE '
			'J': translated_text += 'ETTT '
			'K': translated_text += 'TET '
			'L': translated_text += 'ETEE '
			'M': translated_text += 'TT '
			'N': translated_text += 'TE '
			'O': translated_text += 'TTT '
			'P': translated_text += 'ETTE '
			'Q': translated_text += 'TTET '
			'R': translated_text += 'ETE '
			'S': translated_text += 'EEE '
			'T': translated_text += 'T '
			'U': translated_text += 'EET '
			'V': translated_text += 'EEET '
			'W': translated_text += 'ETT '
			'X': translated_text += 'TEET '
			'Y': translated_text += 'TETT '
			'Z': translated_text += 'TTEE '
			
			'1': translated_text += 'ETTTT '
			'2': translated_text += 'EETTT '
			'3': translated_text += 'EEETT '
			'4': translated_text += 'EEEET '
			'5': translated_text += 'EEEEE '
			'6': translated_text += 'TEEEE '
			'7': translated_text += 'TTEEE '
			'8': translated_text += 'TTTEE '
			'9': translated_text += 'TTTTE '
			'0': translated_text += 'TTTTT '
			
			'.': translated_text += 'ETETET '
			',': translated_text += 'TTEETT '
			'?': translated_text += 'EETTEE '
			'!': translated_text += 'TETETT '
			':': translated_text += 'TTTEEE '
			';': translated_text += 'TETETE '
			'+': translated_text += 'ETETE '
			'-': translated_text += 'TEEEET '
			'=': translated_text += 'TEEET '
			"'": translated_text += 'ETTTTE '
			'/': translated_text += 'TEETE '
			'"': translated_text += 'ETEETE '
			'(': translated_text += 'TETTE '
			')': translated_text += 'TETTET '
			'&': translated_text += 'ETEEE '
			'@': translated_text += 'ETTETE '
			
			' ': translated_text += '|'
	return translated_text

func highlight_specific_word(text: String, idx: int) -> String:
	var split_text: PackedStringArray = text.split(' ')
	var has_slash = split_text[idx].begins_with('|')
	
	if has_slash:
		split_text[idx] = split_text[idx].trim_prefix('|')
	
	split_text[idx] = '[color=red]' + split_text[idx] + '[/color]'
	
	if has_slash:
		split_text[idx] = '|' + split_text[idx]
	
	return ' '.join(split_text)

func highlight_specific_letter(text: String, idx: int) -> String:
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

func remove_last_word(text: String):
	var split_text: PackedStringArray = text.split('|')
	split_text = split_text.slice(0, -2)
