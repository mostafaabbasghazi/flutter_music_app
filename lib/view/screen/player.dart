import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> songData;
  const Player({super.key, required this.songData});

  @override
  Widget build(BuildContext context) {
    PlayerController controller =Get.put(PlayerController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAG Player",style: TextStyle(fontSize: 20,color: Colors.black),),
        centerTitle: true,
      ) ,
      body: 
        Column(
            children: [
              Obx(
                ()=> Expanded(child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    
                    color: Colors.blue,
                    shape: BoxShape.circle
                  ),
                  child: QueryArtworkWidget(id: songData[controller.playIndex.value].id , type: ArtworkType.AUDIO,artworkHeight: double.infinity,artworkWidth: double.infinity,),
                ),),
              ),const SizedBox(height: 20,),
              Obx(
                ()=> Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top:Radius.circular(20) ,),
                      color: Colors.red
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(songData[controller.playIndex.value].displayNameWOExt.toString(),style: TextStyle(fontSize: 24),textAlign: TextAlign.center,maxLines: 1,),
                        SizedBox(height: 12,),
                        Text(songData[controller.playIndex.value].artist.toString(),style: TextStyle(fontSize: 20),maxLines: 1,),
                        SizedBox(height: 12,),
                        Row(
                          children: [
                            Text(controller.duration.value,style: TextStyle(fontSize: 20),),
                            Expanded(child: Slider(
                              min: Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,
                              value: controller.value.value, 
                              onChanged: (newValue){
                              controller.cahngDurationToSecand(newValue.toInt());
                              newValue=newValue;
                            })),
                            Text(controller.posison.value,style: TextStyle(fontSize: 20),),
                          ],
                        ),SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          IconButton(onPressed: (){
                            controller.playSound(songData[controller.playIndex.value+1].uri.toString(), controller.playIndex.value-1);
                          }, icon: Icon(Icons.skip_previous_outlined,size: 35,)),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white10,
                            child: Transform.scale(
                              scale: 3,
                              child: IconButton(onPressed: (){
                                if(controller.isPlay.value){
                                  controller.audioPlayer.pause();
                                  controller.isPlay(false);
                                }else{
                                  controller.audioPlayer.play();
                                  controller.isPlay(true);
                                }
                              },
                               icon:controller.isPlay.value? Icon(Icons.pause,size: 30,):Icon(Icons.play_arrow,size: 30,)),
                            )
                          ),
                          IconButton(onPressed: (){
                            controller.playSound(songData[controller.playIndex.value-1].uri.toString(), controller.playIndex.value+1);
                          }, icon: Icon(Icons.skip_next_outlined,size: 35,)),
                        ],)
                            
                      ],
                    ),
                                ),
                  ),
              )
            ],
          ),
      
      
    );
  }
}