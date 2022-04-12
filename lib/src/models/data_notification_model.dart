class DataNotificationModel {
  DataNotificationModel({
    this.route,
    this.arguments,
  });

  String? route;
  String? arguments;

  factory DataNotificationModel.fromJson(Map<String, dynamic> json) {
    return DataNotificationModel(
      route: json['route'] as String,
      arguments: json['arguments'] as String,
    );
  }
}
