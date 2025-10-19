import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirage/default/text_styles.dart';

import '../../../default/app_assets.dart';
import '../../../default/colors.dart';

class EthereumLoadingDefault extends StatefulWidget {
  const EthereumLoadingDefault({super.key, required this.loadingText});

  final String loadingText;

  @override
  State<EthereumLoadingDefault> createState() => _EthereumLoadingDefaultState();
}

class _EthereumLoadingDefaultState extends State<EthereumLoadingDefault>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          RotationTransition(
            turns: _animationController,
            child: SvgPicture.asset(AppAssets.ethereumPath, height: 40),
          ),
          Text(
            widget.loadingText,
            style: TextStylesDefault.robotoSubtitleSemiBold.copyWith(
              color: AppColors.warmBrown,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
