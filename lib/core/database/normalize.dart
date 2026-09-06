/// Normaliza uma descrição para busca "ignorando acentos e caixa" (RF-14).
///
/// Gravada junto com o lançamento, não calculada em tempo de consulta: o
/// `LIKE` do SQLite não faz *accent folding*, então sem esta coluna o RF-14
/// seria impossível como escrito.
String? normalizeForSearch(String? description) {
  if (description == null) return null;

  const withAccents = 'áàâãäåéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÅÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ';
  const withoutAccents = 'aaaaaaeeeeiiiiooooouuuucnAAAAAAEEEEIIIIOOOOOUUUUCN';

  final buffer = StringBuffer();
  for (final char in description.split('')) {
    final index = withAccents.indexOf(char);
    buffer.write(index == -1 ? char : withoutAccents[index]);
  }
  return buffer.toString().toLowerCase();
}
