import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';

class Admob {
  void init() async {
    String appId = GetIt.I<RemoteConfig>().getString("admobAppID");

    FirebaseAdMob.instance.initialize(appId: appId);
  }

  void initAd() {
    BannerAd ba = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: MobileAdTargetingInfo(
        keywords: <String>['flutterio', 'beautiful apps'],
        contentUrl: 'https://flutter.io',
        // ignore: deprecated_member_use
        birthday: DateTime.now(),
        childDirected: false,
        // ignore: deprecated_member_use
        designedForFamilies: false,
        // ignore: deprecated_member_use
        gender: MobileAdGender
            .male, // or MobileAdGender.female, MobileAdGender.unknown
        testDevices: <String>[],
      ),
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    ba
      ..load()
      ..show(
        anchorOffset: 100.0,
        anchorType: AnchorType.bottom,
      );
  }
}
