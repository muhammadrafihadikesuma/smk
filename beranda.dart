import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smk/menu/detailberanda.dart';
import 'package:smk/server/api.dart';
import 'package:timeago/timeago.dart';
import 'package:smk/server/serverberanda.dart';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  var loading = false;
  TimeAgo ta = new TimeAgo();
  final list = new List<BerandaModel>();
  _lihatdata() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.lihatBeranda);
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new BerandaModel(
          api['idberanda'],
          api['judul'],
          api['berita'],
          api['isiberita'],
          api['image'],
          api['createdDate'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _lihatdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final x = list[i];
                return new Card(
                  elevation: 1.7,
                  child: new Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                              padding: new EdgeInsets.all(5.0,),
                              child: new Text(
                                timeAgo(DateTime.parse(x.createdDate)),
                                style: new TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            new Padding(
                              padding: new EdgeInsets.all(5.0),
                              child: new Text("by ${x.idberanda}",
                                style: new TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        new Row(
                          children: [
                            new Expanded(
                              child: new GestureDetector(
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Padding(
                                      padding: new EdgeInsets.only(
                                          left: 4.0,
                                          right: 8.0,
                                          bottom: 4.0,
                                          top: 3.0),
                                      child: new Text(
                                        x.judul,
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(
                                        left: 4.0,
                                        right: 8.0,
                                        bottom: 8.0,
                                        top: 4.0,
                                      ),
                                      child: new Text(
                                        x.isiberita,
                                        style: new TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) => new DetailBeranda(x)
                                ))
                              ),
                            ),


                            new Column(
                              children: <Widget>[
                                new Padding(
                                  padding: new EdgeInsets.only(
                                    top: 8.0,
                                  ),
                                  child: new SizedBox(
                                    height: 100.0,
                                    width: 100.0,
                                    child: new Image.network(
                                      'http://192.168.43.175/smk/img/' +
                                          x.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                new Row(
                                  children: <Widget>[
                                    // new Padding(
                                    //   padding: new EdgeInsets.all(5.0),
                                    //                     child: new Text(
                                    //                       x.createdDate
                                    //                     ),
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
