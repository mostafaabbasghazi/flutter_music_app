import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_getx/controller/player_controller.dart';
import 'package:music_player_getx/view/screen/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    PlayerController controller =Get.put(PlayerController());
    return GetBuilder<PlayerController>(
      builder: (controller){
        return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),

        ],
        title: const Text("MAG Player",style: TextStyle(fontSize: 20,color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<SongModel>>(
          future: controller.audioQuiry.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL
      ), 
          builder: (BuildContext context,snapShot){
            if(snapShot.hasError){
              return const Center(child: Text("Try Again Later",style: TextStyle(fontSize: 20),),);
            }
           
            if(snapShot.hasData){
              return ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (contex,index){
                  return  Container(
                child: Obx(
                  ()=> ListTile(
                    onTap: (){
                      Get.to(()=> Player(songData:snapShot.data! ,),transition: Transition.downToUp);
                      controller.playSound(snapShot.data![index].uri.toString(), index);
                      
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: Text("${snapShot.data![index].displayNameWOExt}",style: const TextStyle(fontSize: 15),),
                    subtitle: Text("${snapShot.data![index].artist}",style: const TextStyle(fontSize: 12),),
                    leading: QueryArtworkWidget(id: snapShot.data![index].id,type: ArtworkType.AUDIO,nullArtworkWidget:const Icon(Icons.music_note) ,),
                    trailing:controller.playIndex.value==index && controller.isPlay.value? const Icon(Icons.stop_circle): const Icon(Icons.play_arrow),
                  
                  ),
                ),
              );
                }
                );
            }
            return Container();
          })
      ),
    );
      }
      );
  }
}