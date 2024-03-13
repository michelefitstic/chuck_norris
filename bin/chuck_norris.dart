import 'package:chuck_norris/chuck_norris.dart' as chuck_norris;
import "dart:io";
import 'package:chuck_norris/services/category_service.dart';

void main(List<String> arguments) async {
  print(
      "Scegli un'operazione: \n1. Ottieni una citazione da una categoria a scelta\n2. Ottieni una citazione random dalla categoria nel file .env\n3. Filtra le citazioni in base a una parola e salvale in un file\n");
  print("Inserisci un numero per scegliere [1/2/3]");
  var choice = stdin.readLineSync();

  switch (choice) {
    case "1":
      final cats = await getCategories();
      for (var i = 0; i < cats.length; i++) {
        print("$i - ${cats[i]}");
      }
      //Chiedi all'utente di inserire un numero (indice)
      print("Inserisci il numero della categoria: ");
      final catIndex = stdin.readLineSync();
      //Prendi il valore dell'array a quell'indice
      final cat = cats[int.parse(catIndex!)];
      print("Categoria scelta: $cat");
      final citazione = await chuck_norris.getCitazioneCategoria(cat);
      print(citazione);
      break;

    case "2":
      final citazione = await chuck_norris.getCitazioneEnv();
      print(citazione);
      break;

    case "3":
      final risultati = await chuck_norris.getCitazioneFilter();
      print(risultati);

    default:
      print("Non hai inserito un numero valido");
  }
  /*final citazione = await chuck_norris.getCitazione();
  print(citazione);*/
}
