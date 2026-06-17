import 'package:flutter/material.dart';

class RejectedScreen
    extends StatelessWidget {

  const RejectedScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            Icon(
              Icons.cancel,
              size: 100,
              color: Colors.red,
            ),

            SizedBox(height: 20),

            Text(
              "Pendaftaran Ditolak",
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Silakan hubungi pengurus koperasi untuk informasi lebih lanjut.",
              textAlign:
                  TextAlign.center,
            ),
          ],
        ),
      ),
    );

  }
}