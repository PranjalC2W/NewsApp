import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_assignment/model/newsModel.dart';

class NewsProvider extends ChangeNotifier {
  List<Articles> _newsData = [];
  bool _isLoading = true;
  String _selectedCountryCode = "IN";

  List<Articles> get newsData => _newsData;
  bool get isLoading => _isLoading;
  String get selectedCountryCode => _selectedCountryCode;

  void setSelectedCountryCode(String code) {
    _selectedCountryCode = code;
    fetchNews();
  }

  NewsProvider() {
    fetchNews();
  }

  void fetchNews() async {
    _isLoading = true;
    notifyListeners();

    log(_selectedCountryCode);
    await Future.delayed(const Duration(seconds: 2)); 
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=$_selectedCountryCode&apiKey=d885b71d234a46d8aa83901ee575ce74");
    http.Response response = await http.get(url);
    var responseData = json.decode(response.body);

    Autogenerated automodel = Autogenerated(responseData);

    _newsData = automodel.articles!;
    _isLoading = false;
    notifyListeners();
  }
}