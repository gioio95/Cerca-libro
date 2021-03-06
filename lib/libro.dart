class Libro {
  String id = '';
  String titolo = '';
  String autori = '';
  String descrizione = '';
  String editore = '';
  String immagineCopertina = '';

  Libro(this.id, this.titolo, this.autori, this.descrizione, this.editore,
      this.immagineCopertina);

  Libro.fromMap(Map<String, dynamic> mappa) {
    this.id = mappa['id'];
    this.titolo = mappa['volumeInfo']['title'];
    this.autori = mappa['volumeInfo']['authors'] == null
        ? ''
        : mappa['volumeInfo']['authors'].toString();
    this.descrizione = mappa['volumeInfo']['description'] == null
        ? ''
        : mappa['volumeInfo']['description'].toString();
    this.editore = mappa['volumeInfo']['publisher'] == null
        ? ''
        : mappa['volumeInfo']['publisher'].toString();
    this.immagineCopertina =
        mappa['volumeInfo']['imageLinks']['smallThumbnail'] == null
            ? ''
            : mappa['volumeInfo']['imageLinks']['smallThumbnail'].toString();
  }
}
