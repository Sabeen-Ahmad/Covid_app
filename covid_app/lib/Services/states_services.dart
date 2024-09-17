import 'dart:convert';
import 'package:covid_tracker/Services/app_uri.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/Model/worldStatesModel.dart';
import 'package:flutter/material.dart';

class StatesServices {
  // Fetch world state records
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUri.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Failed to load world states data. Status code: ${response.statusCode}');
    }
  }

  // Fetch the list of countries
  Future<List<dynamic>> countriesList() async {
    final response = await http.get(Uri.parse(AppUri.countriesList));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Failed to load countries list. Status code: ${response.statusCode}');
    }
  }
}
