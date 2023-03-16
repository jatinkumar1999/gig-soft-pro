class UserAuthModel {
  List<Data>? data;

  UserAuthModel({this.data});

  UserAuthModel.fromJson(List ?json) {
    print('jspn is ==>>>$json');
    if (json!= null) {
      data = <Data>[];
      json.forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? pass;

  Data({this.name, this.pass});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pass = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['pass'] = this.pass;
    return data;
  }
}
