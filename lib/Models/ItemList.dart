
//classe
class ItemList {
  int id;
  String name;
//contructeur
  ItemList(this.id, this.name);
  //conversiond e nos donnee en object
  ItemList.fromMap(Map<String, dynamic> map):
  id = map["id"],
  name = map["name"];
}
