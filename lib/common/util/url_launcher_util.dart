import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherUtil {
  Future<void> launchUrlLink(String url, Function(String) onError) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      } else {
        onError('Could not launch Url: $url');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
