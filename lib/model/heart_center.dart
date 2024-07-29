class HeartCenter {
  HeartCenter(
      {required this.title,
      required this.description,
      required this.serviceList,
      required this.aboutPageTitle,
      required this.aboutPageHTML});

  String title;
  String description;
  List<HeartService> serviceList;
  String aboutPageTitle;
  String aboutPageHTML;

  factory HeartCenter.fromJson(Map<String, dynamic> json) {
    var serviceList = <HeartService>[];
    var serviceListObj = json['serviceList'];
    if (serviceListObj is List) {
      for (var svc in serviceListObj) {
        serviceList.add(HeartService.fromJson(svc));
      }
    }

    return HeartCenter(
        title: json['title'] as String,
        description: json['description'] as String,
        aboutPageTitle: json['aboutPageTitle'] as String,
        aboutPageHTML: json['aboutPageHTML'] as String,
        serviceList: serviceList);
  }
}

class HeartService {
  HeartService(
      {required this.id,
      required this.description,
      required this.title,
      required this.phone,
      required this.imageAssetPath,
      this.infoPageList});

  String id;
  String title;
  String description;
  String phone;
  String imageAssetPath;
  List<HeartServiceInfoPage>? infoPageList;

  factory HeartService.fromJson(Map<String, dynamic> json) {
    var pageList = <HeartServiceInfoPage>[];
    var pageListObj = json['serviceInfoPageList'];
    if (pageListObj is List) {
      for (var page in pageListObj) {
        pageList.add(HeartServiceInfoPage.fromJson(page));
      }
    }

    return HeartService(
      id: json['serviceId'] as String,
      description: json['serviceDescription'] as String,
      title: json['serviceTitle'] as String,
      phone: json['servicePhone'] as String,
      imageAssetPath: json['serviceImageAssetPath'] as String,
      infoPageList: pageList,
    );
  }
}

class HeartServiceInfoPage {
  HeartServiceInfoPage(
      {required this.title, required this.html, required this.headingText});

  String title;
  String html;
  String headingText;

  factory HeartServiceInfoPage.fromJson(Map<String, dynamic> json) {
    return HeartServiceInfoPage(
        title: json['serviceInfoPageTitle'],
        html: json['serviceInfoPageHTML'],
        headingText: json['serviceInfoPageHeadingText']);
  }
}
