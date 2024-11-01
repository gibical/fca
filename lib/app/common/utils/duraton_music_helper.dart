
class DurationMusic{
  static Duration duration = Duration.zero;


  static Duration position = Duration.zero;


  static formtTime(Duration value){
    String digit(int n) => n.toString().padLeft(2 , '0');
    final hour = digit(value.inHours);
    final min = digit(value.inMinutes.remainder(60));
    final sec = digit(value.inSeconds.remainder(60));
    return [
      if(value.inHours > 0) hour,min,sec
    ].join(":");
  }



}