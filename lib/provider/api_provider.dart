import 'dart:convert' as convert;
import 'dart:io';
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
      print(response.body);
      print("Successfully fetched json data");
      return myModels;
    } else {
      throw Exception('Failed to load users');
    }
  }

  postAddQueues(Map<String,dynamic> credentials, String endpoint)async{
    var fullURL = baseURL + endpoint;
    Response response = await http.post(Uri.parse(fullURL),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: convert.Encoding.getByName('utf-8'),
      body: credentials,
    );


    if (response.statusCode == 200){
      print("Successfully added queue");
      return convert.json.decode(response.body);
    } else {
      return "Failed to add queue";
    }
  }

  postQueues(String endpoint, String? userId)async{
    // var fullURL = baseURL + endpoint;
    final body = {
      'userId': userId,
    };
    final jsonBody = convert.jsonEncode(body);
    print(jsonBody);
    final uri = Uri.parse(baseURL+endpoint);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
    );

    List<QueuesModel> queues;
    queues = (convert.json.decode(response.body) as List).map((i) =>
        QueuesModel.fromJson(i)).toList();

    if (response.statusCode == 200){
      print("Successfully fetched json data");
      return queues;
    } else {
      return 'Failed to load queues';
    }



    // final queryParameters = {
    //   'userId': 'userId',
    // };
    // final uri = Uri.http(baseURL, endpoint, queryParameters);
    // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    // Response response = await http.get(uri,headers: headers);
    // print(response.body);
    //
    // //converting json data to list

    //

  }
}