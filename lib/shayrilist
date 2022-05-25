import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shayari/data.dart';
import 'package:shayari/first.dart';
import 'package:shayari/second.dart';
class shayrilist extends StatefulWidget {
  int? pos;
  String? catname;
  shayrilist(this.pos,this.catname);





  @override
  _shayrilistState createState() => _shayrilistState();
}

class _shayrilistState extends State<shayrilist> {
  List templist=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.pos==0)
      {
        templist=data.lovesh;
      }
    if(widget.pos==1)
    {
      templist=data.friendsh;
    }
    if(widget.pos==2)
    {
      templist=data.lifesh;
    }
    if(widget.pos==3)
    {
      templist=data.sadsh;
    }
    if(widget.pos==4)
    {
      templist=data.funnysh;
    }
    if(widget.pos==5)
    {
      templist=data.bewafash;
    }
    if(widget.pos==6)
    {
      templist=data.attitudesh;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.black,title: Text("${widget.catname}"),),
      body: ListView.builder(
        itemCount: templist.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title:  Text(templist[index]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return first(index,templist,"singlecolor");
                },));
              },
            ),
          );
        },
      ),
    );
  }
}
// return
