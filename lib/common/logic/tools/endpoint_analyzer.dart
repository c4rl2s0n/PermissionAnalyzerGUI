
import 'dart:io';

class EndpointAnalyzer{
  static Future<String?> lookupHostname(String ip)async{
    try {
      InternetAddress domain = await InternetAddress(ip).reverse();
      if (domain.host.isEmpty) return null;
      return domain.host;
    }catch(_){
      return null;
    }
  }
}