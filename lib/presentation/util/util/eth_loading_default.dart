import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirage/default/text_styles.dart';

import '../../../default/app_assets.dart';
import '../../../default/colors.dart';

/// A loading indicator widget for Ethereum-related operations.
///
/// Shows a rotating Ethereum logo with a custom loading text below it.
class EthereumLoadingDefault extends StatefulWidget {
  /// Creates an [EthereumLoadingDefault] widget.
  ///
  /// [loadingText] is displayed below the rotating Ethereum logo.
  const EthereumLoadingDefault({super.key, required this.loadingText});

  /// The text displayed below the Ethereum logo while loading.
  final String loadingText;

  @override
  State<EthereumLoadingDefault> createState() => _EthereumLoadingDefaultState();
}

class _EthereumLoadingDefaultState extends State<EthereumLoadingDefault>
    with SingleTickerProviderStateMixin {

  /// Animation controller used to rotate the Ethereum logo continuously.
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Continuously rotate the logo
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
          /// Rotating Ethereum logo
          RotationTransition(
            turns: _animationController,
            child: SvgPicture.asset(AppAssets.ethereumPath, height: 40),
          ),

          /// Loading text
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
