import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobilequemanagement_frontend/model/user_model.dart';

class apiProvider{
  final String baseURL = "https://ustp-queueing-system.onrender.com/";

  login(Map credentials, String endpoint)async{
    var fullURL = baseURL + endpoint;
    return await http.post(Uri.parse(fullURL),
      body: jsonEncode(credentials),
      headers: setHeaders(),
    );
  }

  setHeaders()=>{
    'Content-type':'application/json',
    'Accept':'application/json'
  };

  getUsers(String endpoint)async{
    var fullURL = baseURL + endpoint;
    Response response = await http.get(Uri.parse(fullURL));

    //converting json data to list
    List<UserModel> myModels;
    myModels = (json.decode(response.body) as List).map((i) =>
        UserModel.fromJson(i)).toList();

    if (response.statusCode == 200){
      print("Successfully fetched json data");
      return myModels;
    } else {
      throw Exception('Failed to load users');
    }
  }
}