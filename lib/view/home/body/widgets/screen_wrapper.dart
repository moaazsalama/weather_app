// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/assets/assets_manger.dart';
import 'package:weather_app/core/helper/constants.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/viewmodel/app/app_bloc.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final bool isOffline;
  const ScreenWrapper({
    Key? key,
    required this.child,
    this.isOffline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _BodyWrapper(
          child: const SizedBox(),
          // left: false,
          // right: false,
        ),
        const _BackgroundView(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
          child: SafeArea(
            left: false,
            right: false,
            child: child,
          ),
        )
        // if (isOffline)
        //   Positioned(
        //     top: context.propHeight(10),
        //     left: 0,
        //     right: 0,
        //     child: Container(
        //       color: Colors.red,
        //       padding: const EdgeInsets.all(8),
        //       child: const Text(
        //         "No Internet Connection",
        //         textAlign: TextAlign.center,
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     ),
        //   )
      ],
    );
  }
}

class _BodyWrapper extends StatelessWidget {
  final AppBloc _appBloc = Modular.get<AppBloc>();
  final Widget child;
  _BodyWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: _appBloc.isDark
                ? [AppColors.backgroundStart, AppColors.backgroundMiddle, AppColors.backgroundEnd].reversed.toList()
                : [
                    AppColors.backgroundStartLight,
                    AppColors.backgroundMiddleLight,
                    AppColors.backgroundEndLight,
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: SafeArea(
        left: false,
        right: false,
        child: child,
      ),
      // child:
    );
  }
}

class _BackgroundView extends StatelessWidget {
  const _BackgroundView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AssetManger.background), fit: BoxFit.cover),
      ),
    );
  }
}
