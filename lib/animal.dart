import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Animal {
  String name;
  String img;
  bool accept = false;

  Animal(this.name, this.img);

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      json['AnimalName'],
      json['Image'],
    );
  }
}

List<Animal> list3 = [];
// list1 = [
// Animal(name: 'Camel', img: 'lib/assets/camel.png', voice: 'none'),
// Animal(name: 'Cat', img: 'lib/assets/cat.png', voice: 'none'),
// Animal(name: 'Cow', img: 'lib/assets/cow.png', voice: 'none'),
// Animal(name: 'Dog', img: 'lib/assets/dog.png', voice: 'none'),
// Animal(name: 'Fox', img: 'lib/assets/fox.png', voice: 'none'),
// Animal(name: 'Hen', img: 'lib/assets/hen.png', voice: 'none'),
// Animal(name: 'Horse', img: 'lib/assets/horse.png', voice: 'none'),
// Animal(name: 'Lion', img: 'lib/assets/lion.png', voice: 'none'),
// Animal(name: 'Panda', img: 'lib/assets/panda.png', voice: 'none'),
// Animal(name: 'Sheep', img: 'lib/assets/sheep.png', voice: 'none'),
// ];

void getAnimals() async {
  print("getAnimals is called");  // Confirm function entry
  try {
    var url = Uri.http('zainabproject.atwebpages.com', '/getanimal.php');
    var response = await http.get(url);
    print("HTTP Status: ${response.statusCode}");  // Log the HTTP status

    if (response.statusCode == 200) {
      print("Response Body: ${response.body}");  // Log the response body
      var jsonResponse = convert.jsonDecode(response.body) as List;
      list3.clear();
      for (var product in jsonResponse) {
        Animal item = Animal.fromJson(product);
        list3.add(item);
      }
      print("Items loaded: ${list3.length}");  // Confirm items have been added
    } else {
      print("Failed to load data: ${response.statusCode}");
    }
  } catch (e, stackTrace) {
    print("An error occurred: $e");
    print("Stack Trace: $stackTrace");  // Print the stack trace for more details
  }
}