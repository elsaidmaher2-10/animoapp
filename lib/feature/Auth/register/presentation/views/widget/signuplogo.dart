
import 'package:animoapp/core/resource/assetvaluemanger.dart';
import 'package:animoapp/core/resource/colormanager.dart';
import 'package:animoapp/core/resource/constantsmanager.dart';
import 'package:animoapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class signuplogo extends StatelessWidget {
  const signuplogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            AssetValueManager.Klog,
            width: screeutilsManager.w72,
          ),
          Text(
            constantManager.animo,
            style: TextStyle(
              fontFamily:
                  FontFamily.OriginalSurfer,
              fontSize: screeutilsManager.s11,
              color: ColorManger.kprimary,
            ),
          ),
          SizedBox(height: screeutilsManager.h9),
          Text(
            constantManager.sinup,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.Otama_ep,
              fontSize: screeutilsManager.s38,
              color: ColorManger.kprimary,
            ),
          ),
        ],
      ),
    );
  }
}
