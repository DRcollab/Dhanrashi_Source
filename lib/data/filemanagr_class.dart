


import 'dart:convert';
import 'dart:io';

import 'package:dhanrashi_mvp/constants.dart';
import 'package:dhanrashi_mvp/data/settings_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileManager{

  static FileManager? _instance;

  FileManager._internal(){
    _instance = this;

  }

  factory FileManager() => _instance ?? FileManager._internal() ;

  Future<String> get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;

  }

  Future<File> get _file async {
    final path = await _directoryPath;
    return File('$path/settimgs.json');

  }

  Future readJsonFile() async {
    String fileContent = '';

    File file = await _file;

    if( await file.exists() == true ){

          try{
            fileContent = await file.readAsString();
            return  json.decode(fileContent);
          }catch (e){

            print(e);


          }



    }
    return null;

  }

  Future<Settings> writeJsonFile( Settings settings) async {
    File file = await _file;
    await file.writeAsString(json.encode(settings));

    return settings;
  }


}

// File Controller


class FileController extends ChangeNotifier{
  String _text = '';
  late Settings _settings = Settings(''
      'images/profiles/profile_image0.ng',
      kPresentTheme,
      'INR',
      'Lakh');

  String get text => _text;
  Settings get settings => settings;

  readSettings() async {
     final result = await FileManager().readJsonFile();
    if(result!=null){
      _settings = Settings.fromJSON(await FileManager().readJsonFile());
    }

    notifyListeners();

  }

  writeSettings(Settings settings) async {
    _settings = await FileManager().writeJsonFile(settings);
    notifyListeners();


  }

}


// context.read<FileController>().writeSettings();

