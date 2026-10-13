import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:desa_digital/features/agenda/domain/entities/event_agenda.dart';

class DetailEventScreen extends StatelessWidget {
  const DetailEventScreen({super.key});

  static const EventAgenda _cadangan = EventAgenda(
    title: "Bazar Ramadhan Desa Gunung Condong",
    image: AppAssets.event1,
    date: "19 September 2026",
    lokasi: "Gedung Kelurahan",
    penyelenggara: "Arga Bina Cipta",
    deskripsi:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets.",
  );

  EventAgenda get _event {
    final argumen = Get.arguments;
    if (argumen is EventAgenda) return argumen;
    return _cadangan;
  }

  @override
  Widget build(BuildContext context) {
    final event = _event;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Detail Acara",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [Icon(Icons.share_outlined)],
        actionsPadding: const EdgeInsets.only(right: 12),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(event.image, fit: BoxFit.contain),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Diselenggarakan oleh ",
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(color: Colors.black),
                        ),
                        TextSpan(
                          text: event.penyelenggara,
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Iconsax.calendar_tick5, color: AppColors.primary),
                      SizedBox(width: 10),
                      Text(
                        event.date,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp, color: AppColors.primary),
                      SizedBox(width: 10),
                      Text(
                        event.lokasi,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "DESKRIPSI",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    event.deskripsi,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(color: Colors.black87),
                    textAlign: TextAlign.justify,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
