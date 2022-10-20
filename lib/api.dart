import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static addcours(Map data) async {
    final response = await http.post(
        Uri.parse(
            'https://projetepharm.000webhostapp.com/article/addcours.php'),
        body: {"data": jsonEncode(data)});

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result[0])
        return result;
      else
        return null;
    } else {
      return null;
    }
  }

  static getcours() async {
    final response = await http.get(Uri.parse(
        'https://projetepharm.000webhostapp.com/article/getcours.php'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  // static getPostUser(String id) async{
  //   final response = await http.post(Uri.parse('https://projetepharm.000webhostapp.com/article/getcours.php'), body: {
  //     "id_user":encrypt(id),
  //     "type": encrypt("1")
  //   });
  //
  //   if(response.statusCode == 200){
  //     return jsonDecode(decrypt(response.body));
  //   } else{
  //     return null;
  //   }
  // }

  static updatecours(Map data) async {
    final response = await http.post(
        Uri.parse(
            'https://projetepharm.000webhostapp.com/article/updatecours.php'),
        body: {
          "data": jsonEncode(data),
          //"type": encrypt("2")
        });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result[0])
        return result;
      else
        return null;
    } else {
      return null;
    }
  }

  static deletecours(List data) async {
    final response = await http.post(
        Uri.parse(
            'https://projetepharm.000webhostapp.com/article/deletecours.php'),
        body: {
          "idCours": jsonEncode(data),
        });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      print(result[0]);
      if (result[0])
        return result;
      else
        return null;
    } else {
      return null;
    }
  }
}
