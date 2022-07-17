class RatingModel {
  final String userID;
  final double ratings;
  final String id;

  RatingModel({
    required this.id,
    required this.ratings,
    required this.userID,
  });

  factory RatingModel.getJson({required Map<String, dynamic> res}) {
    return RatingModel(
      id: res['_id'],
      ratings: res['ratings'],
      userID: res['userID'],
    );
  }

  Map<String, dynamic> sendJson() {
    return {
      'userID': userID,
      'ratings': ratings,
      '_id': id,
    };
  }
}
