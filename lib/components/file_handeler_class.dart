import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';




class JsonHandler{

  var jsonFile;
  var dir;
  String filePath = '';
  String fileName = '';
  bool readSuccessful = false;
  //String fileContent = '';
  bool fileExists = false;
  late Map<String, dynamic> fileContent = Map.of({'profile':''});

  JsonHandler({required this.fileName}){
    _initFile();
   // print('PATH= ${dir.path}');

  }


///initilizes the file
  Future<void> _initFile() async {
      dir =  await getApplicationSupportDirectory();

      filePath = dir.path + '/' + fileName;
    //  print('path : ${filePath}');
      jsonFile = File(filePath);
      fileExists = await jsonFile.exists();
      print(filePath);
      if(fileExists) {
        fileContent = json.decode(jsonFile.readAsStringSync());
        //print(fileContent);
      }
    ;
  }

  Future<File> createFile(Map<String, dynamic> content) async {


    dir =  await getApplicationDocumentsDirectory();

    filePath = dir.path + '/' + fileName;
    jsonFile = File(filePath);
    fileExists = await jsonFile.exists();
    File file = File(filePath);
    if(!fileExists){

      file.createSync();

      fileExists = true;
     // print(content);
      file.writeAsString(json.encode(content));
    }
     else{
       print('file exists');
    }

      return file;

    }

    Future<void> readFile() async {
      dir =  await getApplicationDocumentsDirectory();

      filePath = dir.path + '/' + fileName;
      jsonFile = File(filePath);
      fileExists = await jsonFile.exists();
      File file = File(filePath);
      if(fileExists){

        try{
          fileContent = json.decode(jsonFile.readAsStringSync());

          readSuccessful = true;
        }catch(e){
          print('Error ::::  ${e.toString()}');
          readSuccessful = false;
      }



      }else{
        print('profile file does not exists');
      }




    }


    void writeToFile(String key, dynamic value){
        Map<String, dynamic> content = {key: value} ;

        if(fileExists){
          Map<String,dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
          jsonFileContent.addAll(content);
          json.encode(jsonFileContent);
        }else{

          createFile(content);
          print(content);
        }


    }

}







