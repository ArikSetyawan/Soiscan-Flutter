import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soiscan/Models/user_interaction.dart';

class HistoryCard extends StatelessWidget {
  final UserInteraction interaction;
  const HistoryCard({
    super.key, required this.interaction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2,
          shadowColor: Colors.grey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 150, child: Text(interaction.interaction.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                              ),
                              child: Text(interaction.interaction.status),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(DateFormat("yyyy-MM-dd HH:mm:ss").format(interaction.datetimePrint)),
                        const SizedBox(height: 5),
                        Text("${interaction.lat}, ${interaction.lng}")
                      ],
                    ),
                    const Spacer(),
                    Image.network(
                      "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                      width: 110,
                      height: 110
                    ),
                  ],
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}