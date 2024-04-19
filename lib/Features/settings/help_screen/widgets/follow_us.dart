import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:team/core/utils/response_font_size.dart';

class FollowUs extends StatelessWidget {
  const FollowUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/QR Code-amico (1).png"),
          Text("Scan Our QR Code!", style: TextStyle(fontSize: getResponseFontSize(context: context, fontSize: 30))),
          const Text("Follow us on Website", style: TextStyle(fontSize: 16)),
          const Gap(15),
          QrImageView(
              data: 'https://www.facebook.com/mohamed.ghaly74',
              version: QrVersions.auto,
              size: MediaQuery.sizeOf(context).width * .5),
        ],
      ),
    );
  }
}
