

abstract class IHttpClient<T>{
  Future<T> getRequest({required String endPoint});
  Future<T> postRequest({required String endPoint, required Map<String, dynamic> data});
}