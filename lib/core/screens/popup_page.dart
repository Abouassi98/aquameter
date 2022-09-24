import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/material.dart';

class PopUpPage extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool safeAreaNavBar;
  final Color? statusBarColor;
  final Color? backgroundColor;
  final Widget body;
  final PlatformAppBar? appBar;
  final dynamic consumerAppBar;
  final bool resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final Widget? drawer;
  final PlatformNavBar? bottomNavigationBar;
  final Function(BuildContext, int)? cupertinoTabChildBuilder;
  final Widget? floatingActionButton;
 final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Future<bool> Function()? onWillPop;

  const PopUpPage({
    Key? key,
    this.scaffoldKey,
    this.safeAreaTop = false,
    this.safeAreaBottom = false,
    this.safeAreaNavBar = false,
    this.statusBarColor,
    this.backgroundColor,
    this.body = const SizedBox(),
    this.appBar,
    this.consumerAppBar,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = false,
    this.drawer,
    this.bottomNavigationBar,
    this.cupertinoTabChildBuilder,
    this.floatingActionButton,
    this.onWillPop,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop ?? () => Future.value(true),
      child: SafeArea(
        top: safeAreaTop,
        bottom: safeAreaBottom,
        child: PlatformScaffold(
          
          widgetKey: scaffoldKey,
          backgroundColor:
              backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          appBar: appBar,
          bottomNavBar: bottomNavigationBar,

          //Use cupertinoTabChildBuilder for showing IOS Tab pages to avoid duplicating page widgets
          cupertinoTabChildBuilder: (_, index) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: statusBarColor != null
                  ? Theme.of(context)
                      .appBarTheme
                      .systemOverlayStyle!
                      .copyWith(statusBarColor: statusBarColor)
                  : Theme.of(context).appBarTheme.systemOverlayStyle!,
              child: SafeArea(
                top: false,
                bottom: safeAreaNavBar,
                child: cupertinoTabChildBuilder!(context, index),
              ),
            );
          },
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value:const SystemUiOverlayStyle(
        //For Android
        statusBarColor:Color(0xFFFAFAFA),
        // For apps with a dark background:
        // For Android (light icons)
        statusBarIconBrightness: Brightness.dark,
        // For iOS (light icons)
        statusBarBrightness: Brightness.light,
      ),
            child: body,
          ),
          material: (_, __) {
            return MaterialScaffoldData(
              appBar: consumerAppBar,
              drawer: drawer,
              
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              extendBodyBehindAppBar: extendBodyBehindAppBar,
            );
          },
          cupertino: (_, __) {
            return CupertinoPageScaffoldData(
              navigationBar: consumerAppBar,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            );
          },
        ),
      ),
    );
  }
}
