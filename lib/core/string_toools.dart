String capitalizeWords(String text) {
  return text
      .split(' ') // separa por espacios
      .map((word) =>
  word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
      .join(' ');
}