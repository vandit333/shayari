import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari/data.dart';
import 'package:shayari/sizedata.dart';
import 'package:shayari/spage.dart';

class first extends StatefulWidget {
  int pos;
  List templist;
  String colortype;


  first(this.pos,this.templist,this.colortype);


  @override
  _firstState createState() => _firstState();
}

class _firstState extends State<first> {

  List<Color> cgd=data.bcolors[0];

  PageController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.pos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               IconButton(onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                  return Container(
                    height: sizwdata.height!-50,
                    child: GridView.builder(
                      itemCount: data.bcolors.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ), itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          widget.colortype="gradient";
                          cgd=data.bcolors[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: data.bcolors[index])
                        ),
                      ),
                    )  ;
                    },),
                  );
                },);
               }, icon:  Icon(Icons.shuffle,size: 30,),),
                Text("   ${widget.pos+1}/${widget.templist.length}   ",style: TextStyle(fontSize: 25),),
                IconButton(onPressed: () {
                  setState(() {
                    widget.colortype="gradient";
                    data.bcolors.shuffle();
                    cgd=data.bcolors[1];
                  });
                }, icon: Icon(Icons.refresh,size: 30,),)
              ],
            ),
            Container(
              height: sizwdata.height!/2.5,
                width: sizwdata.width!-50,

                decoration: BoxDecoration(
                  color: widget.colortype=="singlecolor"?Colors.pink:null,
                  gradient: widget.colortype=="gradient"?LinearGradient(colors: cgd):null
                ),
                alignment: Alignment.center,
                child: PageView.builder(itemCount: widget.templist.length,
                    onPageChanged: (value) {
                      setState(() {
                        widget.pos=value;
                      });
                    }
                    ,itemBuilder: (context, index) {
                      return  Padding(
                        padding: const EdgeInsets.only(left: 50,top: 130),
                        child: Text(widget.templist[widget.pos],

                        ),
                      );

                    },),
                // child: Text(widget.templist[widget.pos])
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(child: Icon(Icons.copy,size: 30,),
                  onTap: () {
                    FlutterClipboard.copy('${widget.templist[widget.pos]}').then(( value ) {
                      Fluttertoast.showToast(
                          msg: "copy",
                      );
                    });
                  },),
                  InkWell(child: Icon(Icons.arrow_back,size: 30,),
                  onTap: () {
                    setState(() {
                      if(widget.pos>0)
                        {
                          widget.pos=widget.pos-1;
                          controller!.jumpToPage(widget.pos);
                        }
                    });
                  },),
                  InkWell(child: Icon(Icons.edit,size: 30,),
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return spage(widget.templist,widget.pos,"singlecolor");
                    },));
                    },

                  ),
                  InkWell(child: InkWell(child: Icon(Icons.arrow_forward,size: 30,),
                  onTap: () {
                    setState(() {
                      if(widget.pos<widget.templist.length-1)
                        {
                          widget.pos=widget.pos+1;
                          controller!.jumpToPage(widget.pos);
                        };
                    });
                  },)),
                  InkWell(child: Icon(Icons.share,size: 30,),
                  onTap: () {
                    Share.share('${widget.templist[widget.pos]}');
                  },),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
