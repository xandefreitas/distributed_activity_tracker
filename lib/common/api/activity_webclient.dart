import 'package:distributed_activity_tracker/common/models/activity.dart';
import 'package:distributed_activity_tracker/common/network/dio_base.dart';

class ActivityWebClient {
  final _dio = DioBase.getDio();

  Future<Activity> getRandomActivity() async {
    try {
      final response = await _dio.get('activity');
      return Activity.fromMap(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Activity> getActivityByKey(String key) async {
    try {
      final response = await _dio.get(
        'activity',
        queryParameters: {'key': key},
      );
      return Activity.fromMap(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Activity> submitSuggestion(Activity activity) async {
    try {
      final response = await _dio.post('suggestion', data: {
        "activity": activity.activity,
        "type": activity.type,
        "participants": activity.participants,
      });
      if (response.data['error'] == null) {
        return activity;
      } else {
        throw Exception(response.data['error']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
