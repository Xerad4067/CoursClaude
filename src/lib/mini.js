// Mini-Markdown pour les textes courts passés en attributs (quiz, indices courts, durées) :
// `code`, **gras** et retours à la ligne. Le HTML est échappé pour éviter toute injection.
export function mini(texte = '') {
	const echappe = String(texte)
		.replace(/&/g, '&amp;')
		.replace(/</g, '&lt;')
		.replace(/>/g, '&gt;')
		.replace(/"/g, '&quot;');
	return echappe
		.replace(/`([^`]+)`/g, '<code>$1</code>')
		.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
		.replace(/\n/g, '<br>');
}
