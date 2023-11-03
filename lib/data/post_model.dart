class PostModel{
  String? id;

  String? title;
  String? description;
  String? uid;
  String? image;
  String? startDate;
  String? endDate;
  String? states;

  PostModel({this.title, this.description, this.uid, this.image, this.startDate, this.endDate, this.states, this.id});

  PostModel.fromJson(Map<String, dynamic> json, String this.id) {
    title = json['title'];
    description = json['description'];
    uid = json['uid'];
    image = json['image'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    states = json['states'];


  }
 Map<String, dynamic> toJson() {
   return {

      'title': title,
      'description': description,
      'uid': uid,
      'image': image,
      'startDate': startDate,
      'endDate': endDate,
      'states': states,
   };
 }

}