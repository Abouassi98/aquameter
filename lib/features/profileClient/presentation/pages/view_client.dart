
import 'package:aquameter/core/utils/constants.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/size_config.dart';
import 'package:aquameter/core/utils/widgets/custom_country_code_picker.dart';
import 'package:aquameter/core/utils/widgets/custom_headear_title.dart';

import 'package:aquameter/core/utils/widgets/custtom_bottom_sheet.dart';
import 'package:aquameter/core/utils/widgets/custom_text_field.dart';
import 'package:aquameter/features/Home/Data/clients_model/clients_model.dart';

import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';

class ViewClient extends StatelessWidget {
  final Client client;

  ViewClient({Key? key, required this.client}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List areaAndCites = [];
  final List listOfCities = [];
  final List listofMeasuer = [];

  @override
  Widget build(BuildContext context) {
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
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    enabled: false,
                                    width: SizeConfig.screenWidth * 0.7,
                                    icon: Icons.person,
                                    hint: client.name,
                                    type: TextInputType.text,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    enabled: false,
                                    showCounterTxt: true,
                                    hint: client.phone.toString(),
                                    icon: Icons.phone,
                                    type: TextInputType.phone,
                                    numbersOnly: true,
                                    width: SizeConfig.screenWidth * 0.7,
                                    maxLength: 11,
                                    suffixIcon: CustomCountryCodePicker(
                                      onChange: (Country value) {},
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    hint: client.governorateData?.names,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    enabled: false,
                                    width: SizeConfig.screenWidth * 0.7,
                                    icon: Icons.person,
                                    hint: client.address,
                                    type: TextInputType.text,
                                  ),
                                  const SizedBox(height: 15),
                                  const CustomHeaderTitle(
                                      title: 'بيانات المزرعه'),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.9,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: SizeConfig.screenHeight *
                                                      0.04),
                                              child: CustomTextField(
                                                paste: false,
                                                type: TextInputType.phone,
                                                hint:
                                                    client.landSize.toString(),
                                                enabled: false,
                                              ),
                                            ),
                                            IgnorePointer(
                                              child: CustomBottomSheet(
                                                staticList: true,
                                                name: client.landSizeType
                                                    .toString(),
                                                list: listofMeasuer,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomTextField(
                                              paste: false,
                                              type: TextInputType.phone,
                                              hint: client.fish?[0].number
                                                  .toString(),
                                              enabled: false,
                                            ),
                                            CustomTextField(
                                              paste: false,
                                              type: TextInputType.phone,
                                              hint: client.fish?[0].type
                                                  .toString(),
                                              enabled: false,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     Padding(
                                  //       padding: EdgeInsets.only(
                                  //           top:
                                  //               SizeConfig.screenHeight * 0.04),
                                  //       child:  CustomTextField(
                                  //         hint: client.fish[0].type.toString(),
                                  //         enabled: false,
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsets.only(
                                  //           top:
                                  //               SizeConfig.screenHeight * 0.04),
                                  //       child: const CustomTextField(
                                  //         hint: 'اسم الشركه',
                                  //         enabled: false,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    hint: client.startingWeight.toString(),
                                    enabled: false,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    hint: client.targetWeight.toString(),
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
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
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
