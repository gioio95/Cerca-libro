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
    try {
      this.autori = mappa['volumeInfo']['authors'] == null
          ? 'Anonimo'
          : mappa['volumeInfo']['authors'].toString();
    } catch (e) {
      this.autori = 'Anonimo';
    }

    try {
      this.descrizione = mappa['volumeInfo']['description'] == null
          ? 'Descrizione non presente'
          : mappa['volumeInfo']['description'].toString();
    } catch (_) {
      this.descrizione = 'Descrizione non presente';
    }
    try {
      this.editore = mappa['volumeInfo']['publisher'] == null
          ? ''
          : mappa['volumeInfo']['publisher'];
    } catch (e) {
      this.editore = '';
    }
    try {
      if (mappa['volumeInfo']['imageLinks']['smallThumbnail'] != null) {
        this.immagineCopertina =
            mappa['volumeInfo']['imageLinks']['smallThumbnail'].toString();
      }
    } catch (e) {
      this.immagineCopertina =
          'https://www.publicdomainpictures.net/pictures/280000/nahled/not-found-image-15383864787lu.jpg';
    }
  }
}
