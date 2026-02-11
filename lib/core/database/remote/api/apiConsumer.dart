abstract class Apiconsumer {
  dynamic get({required String path, required Map<String, dynamic> queryparam});
  dynamic post({
    required String path,
    Map<String, dynamic>? queryparam,
    required Map data,
  });
}
