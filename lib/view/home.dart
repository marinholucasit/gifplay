import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search;
  int _offSet = 0;
  
  Future<Map> _getGif() async{   
    final _APIKEY        = 'LwP25rDNm9cleJeqKmordrQseGqzW51h';
    final _URL_TOPGIFS   = 'https://api.giphy.com/v1/gifs/trending?api_key=$_APIKEY&limit=20&rating=G';
    final _URL_SEARCHGIF = 'https://api.giphy.com/v1/gifs/search?api_key=$_APIKEY&q=$_search&limit=20&offset=$_offSet&rating=G&lang=pt';

    http.Response response;
    if (_search == null)
      response = await http.get(_URL_TOPGIFS);
      
    return Json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}