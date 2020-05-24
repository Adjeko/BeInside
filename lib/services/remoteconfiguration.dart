import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';

class RemoteConfiguration {
  
  final defaults = <String,dynamic>{
    "admobAppID" : "",
    "twitterConsumerSecret" : "",
    "twitterConsumerKey" : "",
  }; 

  void init() async {
    final RemoteConfig rC = await RemoteConfig.instance;
    if (!GetIt.I.isRegistered<RemoteConfig>()) {
      GetIt.I.registerSingleton<RemoteConfig>(await RemoteConfig.instance);
    }
    
    await rC.setDefaults(defaults);

    await rC.fetch(expiration: const Duration(days: 1));
    await rC.activateFetched();
  }

}