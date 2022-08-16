import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayari/sizedata.dart';
import 'package:shayari/data.dart';
import 'dart:ui' as ui;

class spage extends StatefulWidget {
  List templist;
  int pos;
  String colortype;

  spage(this.templist, this.pos,this.colortype);

  @override
  _spageState createState() => _spageState();
}

class _spageState extends State<spage> {
  double cvalue = 10;
  List<String> fonts = ["hello"];
  String emogi1 = "";
  String font1 = "";
  Color bgcolor = Colors.white;
  Color txtcolor = Colors.black;
  List<Color> cgd=data.bcolors[0];

  GlobalKey _globalKey = new GlobalKey();

  Future<Uint8List> _capturePng() async {
    var pngBytes;
    try {
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
    } catch (e) {}
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    sizwdata(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Shayari"),
      ),
      body: Container(
        child: Column(
          children: [
            RepaintBoundary(
              child: Container(
                alignment: Alignment.center,
                height: sizwdata.height! / 2.6,
                width: sizwdata.width,
                decoration: BoxDecoration(

                    color: widget.colortype=="singlecolor"?bgcolor:null,
                    gradient: widget.colortype=="gradient"?LinearGradient(colors: cgd):null
                ),
                // color: bgcolor,
                margin: EdgeInsets.all(50),
                child: SingleChildScrollView(
                    child: Text(
                  "${widget.templist[widget.pos]}$emogi1",
                  style: TextStyle(fontSize: cvalue, fontFamily: font1,color: txtcolor),
                )),
              ), //   divisions: 8,
              //   divisions: 8,
              key: _globalKey,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 200,
                                    child: GridView.builder(
                                      itemCount: data.colorlist.length,
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: 3),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget.colortype="singlecolor";
                                                bgcolor = data.colorlist[index];
                                              });
                                            },
                                            child: Container(
                                              color: data.colorlist[index],
                                            ),
                                          );
                                        },),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              height: sizwdata.height! / 8,
                              width: sizwdata.width! / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 10),
                                color: Colors.grey,
                              ),
                              alignment: Alignment.center,
                              child: Text("Background"),
                            ),
                          ),


                             InkWell(
                              onTap: () {
                                showModalBottomSheet(context: context, builder: (context) {
                                  return SizedBox(
                                    height: 200,
                                    child: GridView.builder(
                                      itemCount: data.colorlist.length,
                                      scrollDirection: Axis.vertical,

                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 3), itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            txtcolor=data.colorlist[index];
                                          });
                                        },
                                        child: Container(
                                          color: data.colorlist[index],
                                        ),
                                      );
                                    },),
                                  );
                                },);
                              },
                              child: Container(
                                height: sizwdata.height! / 8,
                                width: sizwdata.width! / 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.white, width: 10),
                                  color: Colors.grey,
                                ),
                                alignment: Alignment.center,
                                child: Text("Text Color"),
                              ),
                            ),

                          InkWell(
                            child: Container(
                              height: sizwdata.height! / 8,
                              width: sizwdata.width! / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 10),
                                color: Colors.grey,
                              ),
                              alignment: Alignment.center,
                              child: Text("Share"),
                            ),
                            onTap: () {
                              //share image
                              _capturePng().then((imgbyte) {
                                var now = new DateTime.now();
                                var formatter = DateFormat('ddmmyy');

                                String actualDate = formatter.format(now);

                                String time =
                                    "${now.hour.toString()}${now.minute.toString()}${now.millisecond.toString()}";
                                String imgname = "IMG_${actualDate}${time}";
                                File f =
                                    File("${data.folderpath}/$imgname.jpg");
                                f.create().then((value) {
                                  f.writeAsBytes(imgbyte).then((value) {
                                    Share.shareFiles(["${value.path}"]);
                                  });
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              height: sizwdata.height! / 8,
                              width: sizwdata.width! / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 10),
                                color: Colors.grey,
                              ),
                              alignment: Alignment.center,
                              child: Text("Font"),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: sizwdata.height! / 5,
                                    child: ListView.builder(
                                      itemCount: data.font.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              font1 = data.font[index];
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "\n${data.font[index]}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: data.font[index]),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: sizwdata.height! / 8,
                              width: sizwdata.width! / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 10),
                                color: Colors.grey,
                              ),
                              alignment: Alignment.center,
                              child: Text("Emoji"),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: sizwdata.height! / 9,
                                    child: ListView.builder(
                                      itemCount: data.emoji.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              emogi1 = data.emoji[index];
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "\n${data.emoji[index]}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: sizwdata.height! / 8,
                              width: sizwdata.width! / 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 10),
                                color: Colors.grey,
                              ),
                              alignment: Alignment.center,
                              child: Text("Text Size"),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: sizwdata.height! / 10,
                                    child: StatefulBuilder(
                                      builder: (context, setState1) {
                                        return Slider(
                                          value: cvalue,
                                          onChanged: (value) {
                                            setState(() {
                                              setState1(() {
                                                cvalue = value;
                                              });
                                            });
                                          },
                                          min: 1,
                                          max: 100,
                                        );

                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
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
                                );
                              },),
                            );
                          },);
                      }, icon:  Icon(Icons.shuffle,size: 30,),),
                      IconButton(onPressed: () {
                        setState(() {
                          widget.colortype="gradient";
                          data.bcolors.shuffle();
                          cgd=data.bcolors[1];
                        });
                      }, icon: Icon(Icons.refresh,size: 30,),)
                      // Icon(
                      //   Icons.repeat,
                      // )
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
