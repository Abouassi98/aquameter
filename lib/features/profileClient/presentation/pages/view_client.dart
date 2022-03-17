import 'package:aquameter/core/GlobalApi/AreaAndCities/manager/area_and_cities_notifier.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_header_title.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/features/CustomMap/presentation/pages/custom_map.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Home/Data/clients_model/client_model.dart';

class ViewClient extends ConsumerWidget {
  final Client client;
  final AreaAndCitesNotifier areaAndCites;
  ViewClient({Key? key, required this.client, required this.areaAndCites})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    return SafeArea(
        child: Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              kAppLogo,
                              height: SizeConfig.screenHeight * 0.1,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 15),
                            const CustomHeaderTitle(title: 'بيانات العميل'),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CustomTextField(
                                    enabled: false,
                                    width: SizeConfig.screenWidth * 0.75,
                                    icon: Icons.person,
                                    hint: client.name,
                                  ),
                                  CustomTextField(
                                    enabled: false,
                                    hint: client.phone.toString(),
                                    icon: Icons.call,
                                    width: SizeConfig.screenWidth * 0.75,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(" اتصل بالعميل "),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.call),
                                        onPressed: () async {
                                          await launch(
                                              "tel:+20${client.phone}");
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomTextField(
                                        width: SizeConfig.screenWidth * .35,
                                        hint: areaAndCites
                                            .governorateModel!.data!
                                            .firstWhere((element) =>
                                                element.id ==
                                                client.governorate)
                                            .name
                                            .toString(),
                                      ),
                                      CustomTextField(
                                        width: SizeConfig.screenWidth * .35,

                                        hint: areaAndCites.areasModel!.data!
                                            .firstWhere((element) =>
                                        element.id == client.area)
                                            .name
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * .75,

                                    child: InkWell(
                                      onTap: () {
                                        push(CustomMap(
                                          show: true,
                                          client: client,
                                          address: client.address,
                                        ));
                                      },
                                      child: CustomTextField(
                                        enabled: false,
                                        width: SizeConfig.screenWidth * 0.7,
                                        icon: Icons.location_pin,
                                        hint: client.address,
                                      ),
                                    ),
                                  ),
                                  const CustomHeaderTitle(
                                      title: 'بيانات المزرعه'),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.9,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'مساحه الارض',
                                              style: MainTheme.hintTextStyle,
                                            ),
                                            Text(
                                              'نوع/م',
                                              style: MainTheme.hintTextStyle,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomTextField(
                                              width: SizeConfig.screenWidth *
                                                  .35,

                                              initialValue:
                                              client.landSize.toString(),
                                              enabled: false,
                                            ),
                                            CustomTextField(
                                              width: SizeConfig.screenWidth *
                                                  .35,

                                              initialValue: client.landSizeType,
                                              enabled: false,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'اجمالي الاسماك',
                                              style: MainTheme.hintTextStyle,
                                            ),
                                            Text(
                                              'النوع',
                                              style: MainTheme.hintTextStyle,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomTextField(
                                              width: SizeConfig.screenWidth *
                                                  .35,

                                              hint: client.fish ? [0].number
                                                  .toString(),
                                              enabled: false,
                                            ),
                                            CustomTextField(
                                              width: SizeConfig.screenWidth *
                                                  .35,

                                              hint: client
                                                  .fish ? [0].fishType!.name,
                                              enabled: false,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'نوع العلف',
                                        style: MainTheme.hintTextStyle,
                                      ),
                                      Text(
                                        'اسم الشركه',
                                        style: MainTheme.hintTextStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomTextField(
                                        width: SizeConfig.screenWidth * .35,

                                        hint: client.feed ?? '',
                                        enabled: false,
                                      ),
                                      CustomTextField(
                                        width: SizeConfig.screenWidth * .35,

                                        hint: client.company ?? '',
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'وزن السمكه الابتدائي بالجرام',
                                    style: MainTheme.hintTextStyle,
                                  ),
                                  CustomTextField(
                                    hint: client.onlinePeriodsResult!.isNotEmpty? client.onlinePeriodsResult![0].startingWeight.toString():'',
                                    enabled: false,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'وزن السمكه المستهدف بالجرام',
                                    style: MainTheme.hintTextStyle,
                                  ),
                                  CustomTextField(
                                    hint: client.onlinePeriodsResult!.isNotEmpty?client.onlinePeriodsResult![0].targetWeight.toString():'',
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(

                    onPressed: () {
                        pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
