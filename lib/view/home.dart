import 'package:audioplayer/consts/colors.dart';
import 'package:audioplayer/consts/text_style.dart';
import 'package:audioplayer/controllers/player_controllers.dart';
import 'package:audioplayer/view/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeViewScreen extends StatelessWidget {
  const HomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
          leading: Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title: Text(
            "Beats",
            style: ourStyle(family: bold, size: 18),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  "No Song Found!",
                  style: ourStyle(),
                ));
              } else {
                print(snapshot.data);
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Obx(
                          () => ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: bgColor,
                            title: Text(
                              snapshot.data![index].displayNameWOExt,
                              style: ourStyle(family: bold, size: 15),
                            ),
                            subtitle: Text(
                              snapshot.data![index].artist,
                              style: ourStyle(family: regular, size: 10),
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Icon(
                                Icons.music_note,
                                color: whiteColor,
                                size: 32,
                              ),
                            ),
                            trailing: controller.playIndex == index &&
                                    controller.isPlaying.value
                                ? Icon(
                                    Icons.play_arrow,
                                    color: whiteColor,
                                    size: 25,
                                  )
                                : null,
                            onTap: () {
                              Get.to(
                                () => PlayerScreen(
                                  data: snapshot.data!,
                                ),
                                transition: Transition.downToUp,
                              );
                              controller.playSong(
                                  snapshot.data![index].uri, index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }));
  }
}
