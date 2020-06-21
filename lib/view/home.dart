import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search;
  int _offSet = 0;
  
  Future<Map> _getGif() async{   
    final _APIKEY        = '';
    final _URL_TOPGIFS   = 'https://api.giphy.com/v1/gifs/trending?api_key=$_APIKEY&limit=20&rating=G';
    final _URL_SEARCHGIF = 'https://api.giphy.com/v1/gifs/search?api_key=$_APIKEY&q=$_search&limit=20&offset=$_offSet&rating=G&lang=pt';

    http.Response response;
    if (_search == null)
      response = await http.get(_URL_TOPGIFS);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Image.network('https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'search here',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGif(),
              builder: (context, snapShot){
                switch(snapShot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white
                        ),
                        strokeWidth: 5.0,
                      ),
                    ); 
                  default:
                    if (snapShot.hasError)
                      return Container();
                    else 
                      return _gifTable(context, snapShot);
                }
              }
            ),
          ),
        ],
      ),     
    );
  }

  Widget _gifTable(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ), 
      itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index){
        return GestureDetector(
          child: Image.network(
            snapshot.data["data"][index]["images"]["fixed_height"]["url"],
            height: 300.0,
            fit: BoxFit.cover,
          ),          
        );
      }
    );
  }

}