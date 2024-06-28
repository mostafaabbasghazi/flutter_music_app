import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
class PlayerController extends GetxController{
  final audioQuiry=OnAudioQuery();
  final audioPlayer=AudioPlayer();
  RxInt playIndex=0.obs;
  RxBool isPlay=false.obs;

  var duration=''.obs;
  var posison=''.obs;

  RxDouble max=0.0.obs;
  RxDouble value=0.0.obs;

  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    await checkPermissons();
  }
  playSound(String sorce,index){
    playIndex.value=index;
  try {
    audioPlayer.setAudioSource(
    AudioSource.uri(Uri.parse(sorce))
    );
    audioPlayer.play();
    isPlay.value=true;
    upDatePostion();
  } catch (e) {
    
  }
  }
  checkPermissons()async{
    var isPer=await Permission.storage.request();
    if(isPer.isGranted){
     
    }else{
      checkPermissons();
    }
  }
  upDatePostion(){
    audioPlayer.durationStream.listen((onData){
      duration.value=onData.toString().split('.')[0];
      max.value=onData!.inSeconds.toDouble() ;
    });
    audioPlayer.positionStream.listen((onData){
      posison.value=onData.toString().split('.')[0];
      value.value=onData.inSeconds.toDouble();
    });
  }
  cahngDurationToSecand(seccand){
    var secand=Duration(seconds: seccand);
    audioPlayer.seek(secand);
  }
}