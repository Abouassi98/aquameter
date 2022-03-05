import 'package:aquameter/core/GlobalApi/fishTypes/manager/fish_types_notifier.dart';
import 'package:aquameter/core/themes/screen_utility.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../Data/clients_model/client_model.dart';

class ClientItem extends StatelessWidget {
  final Client client;
  final FishTypesNotifier? fishTypes;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final void Function() func;
  const ClientItem(
      {Key? key,
      required this.client,
      required this.func,
      this.fishTypes,
      this.confirmDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const ValueKey(0),
      direction: confirmDismiss != null
          ? DismissDirection.startToEnd
          : DismissDirection.none,
      onDismissed: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
        } else {}
      },
      confirmDismiss: confirmDismiss,
      child: InkWell(
        onTap: func,
        child: Card(
          color: Colors.white,
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // Shop Image
                FadeInImage.assetNetwork(
                  height: SizeConfig.screenHeight * 0.1,
                  image: fishTypes!.fishTypesModel!.data!
                      .firstWhere((element) =>
                          element.id == client.fish![0].fishType!.id)
                      .photo
                      .toString(),
                  placeholder: 'assets/images/about.png',
                  fadeInDuration: const Duration(seconds: 1),
                  fit: BoxFit.fill,
                  imageCacheHeight: 500,
                  imageCacheWidth: 500,
                ),
                // Shop Details
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      children: [
                        // Shop name and distance
                        Text(
                          client.name!,
                          style: MainTheme.headingTextStyle
                              .copyWith(fontSize: 10, color: Colors.black),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          '${client.governorateData!.names} - ${client.areaData!.names}',
                          style: MainTheme.headingTextStyle.copyWith(
                              fontSize: 10, color: const Color(0xFF8D8E98)),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          client.address!,
                          style: MainTheme.headingTextStyle.copyWith(
                              fontSize: 10, color: const Color(0xFF8D8E98)),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  inactiveTrackColor: const Color(0xFF8D8E98),
                                  activeTrackColor: MainStyle.primaryColor,
                                  thumbColor: Colors.blue[400],
                                  overlayColor: const Color(0xff282759),
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 5),
                                  overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 7),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Slider(
                                    value: 0,
                                    min: 0,
                                    max: 100,
                                    onChanged: (double newValue) {},
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '0 %',
                              style: MainTheme.headingTextStyle
                                  .copyWith(fontSize: 10, color: Colors.black),
                            ),
                          ],
                        ),
                        //  View CVount
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
