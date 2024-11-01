abstract class RequestInterface{
  void onSucces(dynamic source,int reqCdoe);
  void onStartReuqest(int reqCode);
  void onError(String content,int reqCode,dynamic bodyError);
}