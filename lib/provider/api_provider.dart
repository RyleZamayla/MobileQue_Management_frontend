import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobilequemanagement_frontend/model/queues_model.dart';
import 'package:mobilequemanagement_frontend/model/user_model.dart';

class apiProvider{
  final String baseURL = "https://ustp-queueing-system.onrender.com/";

  postLogin(Map<String,dynamic> credentials, String endpoint)async{
    print(credentials);
    var fullURL = baseURL + endpoint;
    Response response = await http.post(Uri.parse(fullURL),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: convert.Encoding.getByName('utf-8'),
      body: credentials,
    );

    
    if (response.statusCode == 200){
      print("Successfully logged in");
      print(convert.json.decode(response.body));
      return convert.json.decode(response.body);
    } else {
      return "Failed to login";
    }
  }



  getUsers(String endpoint)async{
    var fullURL = baseURL + endpoint;
    Response response = await http.get(Uri.parse(fullURL));

    //converting json data to list
    List<UserModel> myModels;
    myModels = (convert.json.decode(response.body) as List).map((i) =>
        UserModel.fromJson(i)).toList();

    if (response.statusCode == 200){
      print("Successfully fetched json users data");
      return myModels;
    } else {
      throw Exception('Failed to load users');
    }
  }

  getQueues(String endpoint, String? userId)async{
    var fullURL = Uri.parse(baseURL + endpoint);

    final body = <String, String?>{
      'userId': userId??'6480231a6cc9103d9cdd61ae',
    };
    final encodedBody = Uri(queryParameters: body).query;
    print(encodedBody);
    print(fullURL.replace(query: encodedBody));
    Response response = await http.get(fullURL.replace(query: encodedBody));
    print(response.body);

    //converting json data to list
    List<QueuesModel> queues;
    queues = (convert.json.decode(response.body) as List).map((i) =>
        QueuesModel.fromJson(i)).toList();

    if (response.statusCode == 200){
      print("Successfully fetched json queues data");
      return queues;
    } else {
      throw Exception('Failed to load queues');
    }
  }
}