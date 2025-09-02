import 'package:avk/core/extension/bool.dart';
import 'package:avk/core/extension/string.dart';

/// base route entity
class BaseRouteEntity{

  /// constructor
  BaseRouteEntity({this.id,this.name,this.status,this.email});

  /// from json to convert into Model

  factory BaseRouteEntity.fromJson(Map<String, String> json) {
    return BaseRouteEntity(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      status: json['status']?.parseStringToBool(),
    );
  }


  /// to json to convert into Map
  Map<String,String> toJson (){
    Map<String,String> hash = <String, String>{};
    if(id !=null) {
      hash['id'] = id!;
    }
    if(status !=null) {
      hash['status'] = status!.parseBoolToString();
    }
    if(name !=null) {
      hash['name'] = name!;
    }
    if(email !=null) {
      hash['email'] = email!;
    }
    return hash;
  }

  /// String id
  String? id;

  ///bool status
  bool? status;

  /// String name
  String? name;
  /// email name
  String? email;

}
