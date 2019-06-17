import 'package:flutter/material.dart';
import 'package:smk/server/serverberanda.dart';


class DetailBeranda extends StatefulWidget {
final BerandaModel model;
DetailBeranda(this.model);

  @override
  _DetailBerandaState createState() => _DetailBerandaState();
}

class _DetailBerandaState extends State<DetailBeranda> {

TextEditingController txtjudul, txtisiberita, txtgambar;

  setup() {
    txtjudul = TextEditingController(text: widget.model.judul);
    txtisiberita = TextEditingController(text: widget.model.isiberita);
    txtgambar = TextEditingController(text: widget.model.image);
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: new Container(
        padding: const EdgeInsets.all(5.0),
        child: new Card(
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: txtjudul,
                
              ),
              TextFormField(
                controller: txtisiberita,
              ),
              TextFormField(
                controller: txtgambar,
              )
            ],
            
        ),
        ),
      ),
    );
  }
}