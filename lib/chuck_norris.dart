import "dart:convert";
import "package:http/http.dart" as http;
import "models/citazione.dart";
import "package:dotenv/dotenv.dart"; //dart pub add dotenv , dart pub global activate dotenv
import "dart:io";

const urlSingleStr = "https://api.chucknorris.io/jokes/random?category";
final urlSingleUri = Uri.parse(urlSingleStr);

const urlMultipleStr = "https://api.chucknorris.io/jokes/search?query";
final urlMultipleUri = Uri.parse(urlMultipleStr);

Future<Citazione> getCitazioneCategoria(String cat) async {
  //Richiesta 1 - citazioni in base alla categoria || "https://api.chucknorris.io/jokes/random?category=fashion";
  final urlSingle = urlSingleUri.replace(queryParameters: {"category": cat});
  final res = await http.get(urlSingle);
  final data = res.body;

  /*return Citazione(
      frase: data['value'], id: data['id'], createdAt: data['created_at']);*/
  return Citazione.fromJson(data);
}

Future<Citazione> getCitazioneEnv() async {
  //Richiesta 2 - citazioni in base a categoria presente in .env || "https://api.chucknorris.io/jokes/random?category=${env['CATEGORY']}";
  final env = DotEnv()..load();
  final cat = env['CATEGORY'];
  final urlSingle = urlSingleUri.replace(queryParameters: {"category": cat});
  final res = await http.get(urlSingle);
  final data = res.body;

  return Citazione.fromJson(data);
  /*return Citazione(
      frase: data['value'], id: data['id'], createdAt: data['created_at']);*/
}

Future<String> getCitazioneFilter() async {
  //Richiesta 3 - citazioni filtrate in base a una parola
  print("Quale stringa deve contenere la citazione?");
  String? keywords = stdin.readLineSync();
  final urlMultiple =
      urlMultipleUri.replace(queryParameters: {"query": keywords});
  //final stringUrl = "https://api.chucknorris.io/jokes/search?query=$keywords";

  //API call
  final res = await http.get(urlMultiple);

  //Mappi il risultato nella variabile data - in questo modo puoi accedere alle varie coppe chiave-valore
  final Map<String, dynamic> data = json.decode(res.body);
  final resArray =
      data['result'] as List; //perchè non List<Map<String, dynamic>>
  final arrayCitazioni = resArray.map((e) => Citazione.fromMap(e));
  final listaCitazioni = arrayCitazioni.toList();

  //Creo un file e scrivo la lista di citazioni resituite
  final file = File('$keywords.txt');
  file.create();
  await file.writeAsString(listaCitazioni.toString());

  return "Risultati trovati: ${data['total']} - Salvati nel file $keywords.txt ";
}
