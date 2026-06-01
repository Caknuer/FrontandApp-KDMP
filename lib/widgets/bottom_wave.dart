import 'package:flutter/material.dart';

class BottomWave extends StatelessWidget {
  const BottomWave({super.key});

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,

      child: SizedBox(
        height: 220,
        width: double.infinity,

        child: Stack(
          children: [

            // GELOMBANG PALING BELAKANG
            Positioned(
              bottom: -40,
              left: -80,
              right: -80,

              child: Container(
                height: 180,

                decoration: BoxDecoration(
                  color: const Color(
                    0xffAF101A,
                  ).withAlpha(20), // 0.08 * 255

                  borderRadius:
                      BorderRadius.circular(200),
                ),
              ),
            ),

            // GELOMBANG TENGAH
            Positioned(
              bottom: -20,
              left: -50,
              right: -50,

              child: Container(
                height: 150,

                decoration: BoxDecoration(
                  color: const Color(
                    0xffAF101A,
                  ).withAlpha(20), // 0.08 * 255

                  borderRadius:
                      BorderRadius.circular(180),
                ),
              ),
            ),

            // GELOMBANG DEPAN
            Positioned(
              bottom: 0,
              left: -20,
              right: -20,

              child: Container(
                height: 120,

                decoration: BoxDecoration(
                  color: const Color(
                    0xffAF101A,
                  ).withAlpha(13), // 0.05 * 255

                  borderRadius:
                      BorderRadius.circular(160),
                ),
              ),
            ),

            // ICON HIASAN KIRI
            Positioned(
              bottom: 90,
              left: 30,

              child: Container(
                width: 45,
                height: 45,

                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withAlpha(13), // 0.05 * 255

                      blurRadius: 10,
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.savings,
                  color: Color(0xffAF101A),
                ),
              ),
            ),

            // ICON HIASAN KANAN
            Positioned(
              bottom: 70,
              right: 35,

              child: Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withAlpha(13), // 0.05 * 255

                      blurRadius: 10,
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.account_balance,
                  color: Color(0xffAF101A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}