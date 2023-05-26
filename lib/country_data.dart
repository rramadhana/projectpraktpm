import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Negara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
      routes: {
        CountryDetailPage.routeName: (context) => CountryDetailPage(),
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Country> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> searchCountries(String keyword) async {
    final String apiUrl = 'https://restcountries.com/v3.1/name/$keyword';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _searchResults = (jsonData as List)
            .map((countryJson) => Country.fromJson(countryJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  void navigateToCountryDetail(Country country) {
    Navigator.pushNamed(
      context,
      CountryDetailPage.routeName,
      arguments: country,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Negara'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    searchCountries(_searchController.text);
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final country = _searchResults[index];
                return ListTile(
                  leading: Image.network(country.flag),
                  title: Text(country.name),
                  onTap: () {
                    navigateToCountryDetail(country);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Country {
  final String name;
  final String flag;
  final int population;
  final String capital;
  final String region;
  final String subregion;
  final double area;

  Country({
    required this.name,
    required this.flag,
    required this.population,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final name = json['name']['official'];
    final flag = json['flags']['png'];
    final population = json['population'];
    final capital = json['capital'].cast<String>().first;
    final region = json['region'];
    final subregion = json['subregion'];
    final area = json['area'];

    return Country(
      name: name,
      flag: flag,
      population: population,
      capital: capital,
      region: region,
      subregion: subregion,
      area: area.toDouble(),
    );
  }
}

class CountryDetailPage extends StatelessWidget {
  static const routeName = '/country_detail';

  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context)?.settings.arguments as Country;

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flag),
            const SizedBox(height: 16.0),
            Text('Population: ${country.population}'),
            Text('Capital: ${country.capital}'),
            Text('Region: ${country.region}'),
            Text('Subregion: ${country.subregion}'),
            Text('Area: ${country.area}'),
          ],
        ),
      ),
    );
  }
}
