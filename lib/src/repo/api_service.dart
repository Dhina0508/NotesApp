// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notesapp/src/views/home_page.dart';

class ApiService {
  static Future fetchData() async {
    final response =
        await http.get(Uri.parse("http://159.89.161.169:3001/api/user/notes"));
    if (response.statusCode == 200) {
      // print(json.decode(response.body) as Map<String, dynamic>);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future postData(Map<String, dynamic> postData, context) async {
    final response = await http.post(
      Uri.parse("http://159.89.161.169:3001/api/user/notes"),
      body: json.encode(postData),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 201) {
      Navigator.pushAndRemoveUntil(
          context,
          (MaterialPageRoute(builder: (context) => const Homepage())),
          (route) => false);
    } else {
      throw Exception('Failed to post data');
    }
  }

  static Future updateData(
      String id, Map<String, dynamic> postData, context) async {
    final response = await http.put(
      Uri.parse("http://159.89.161.169:3001/api/user/notes/$id"),
      body: json.encode(postData),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          (MaterialPageRoute(builder: (context) => const Homepage())),
          (route) => false);
    } else {
      throw Exception('Failed to update data');
    }
  }

  static Future deleteData(String id) async {
    final response = await http.delete(
      Uri.parse("http://159.89.161.169:3001/api/user/notes/$id"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      // Map<String, dynamic> data = json.decode(response.body);

      // return data;
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
