import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayari/data.dart';
import 'package:shayari/shayrilist.dart';
import 'package:shayari/sizedata.dart';

void main() {
  runApp(MaterialApp(
    home: demo(),
  ));
}

class demo extends StatefulWidget {
  @override
  _demoState createState() => _demoState();
}

class _demoState extends State<demo> {
  permission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.storage]);
    var status = await Permission.storage.status;
    if (status.isGranted) {
      createFolder().then((value) {
        print(value);
        setState(() {
          data.folderpath = value;
        });
      });
    } else {
      permission();
    }
  }

  Future<String> createFolder() async {
    final foldername = "My folder";
    var defaultpath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final path = Directory("$defaultpath/$foldername");
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
  }

  @override
  Widget build(BuildContext context) {
    sizwdata(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("SHAYRI"),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 1) {
                  print("Setting");
                }
                if (value == 2) {
                  print("Logout");
                }
                if (value == 3) {
                  print("Help");
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Setting"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Logout"),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: 3,
                ),
                PopupMenuItem(
                  child: Text("Info"),
                  onTap: () {
                    print("Info");
                  },
                ),
              ],
            )
          ],
        ),
        body: ListView.builder(
          itemCount: data.imagelist.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(data.catlist[index]),
                leading: Container(
                  height: sizwdata.height! / 10,
                  width: sizwdata.width! / 10,
                  child: Image.asset(
                    data.imagelist[index],
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return shayrilist(index, data.catlist[index]);
                    },
                  ));
                },
              ),
            );
          },
        ));
  }
}
