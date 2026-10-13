import 'dart:convert';

import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'dart:ui' as ui;

class PemilihLokasiScreen extends StatefulWidget {
  const PemilihLokasiScreen({super.key});

  @override
  State<PemilihLokasiScreen> createState() => _PemilihLokasiScreenState();
}

class _PemilihLokasiScreenState extends State<PemilihLokasiScreen> {
  final MapController mapController = MapController();

  LatLng selectedLocation = const LatLng(-6.194573, 106.891412);

  String alamat = 'Pilih titik lokasi pada peta';

  bool isLoading = false;

  Future<void> getAddress(LatLng position) async {
    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse'
        '?lat=${position.latitude}'
        '&lon=${position.longitude}'
        '&format=json'
        '&addressdetails=1',
      );

      final response = await http.get(
        url,
        headers: {'User-Agent': 'desa_digital/1.0'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final address = data['address'];

        setState(() {
          alamat = [
            address['road'],
            address['village'],
            address['town'],
            address['city'],
            address['county'],
            address['state'],
          ].where((e) => e != null && e.toString().isNotEmpty).join(', ');
        });
      } else {
        setState(() {
          alamat = 'Alamat tidak ditemukan';
        });
      }
    } catch (e) {
      setState(() {
        alamat = 'Gagal mendapatkan alamat';
      });

      debugPrint('Reverse geocoding error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: selectedLocation,
                  initialZoom: 15,

                  onPositionChanged: (position, hasGesture) {
                    selectedLocation = position.center;
                  },

                  onMapEvent: (event) {
                    if (event is MapEventMoveEnd) {
                      getAddress(selectedLocation);
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                    subdomains: const ['a', 'b', 'c', 'd'],
                    userAgentPackageName: 'com.hafidtech.desa_digital',
                  ),
                ],
              ),

              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Titik Lokasi",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      bottom: -8,
                      child: ClipPath(
                        clipper: TriangleClipper(),
                        child: Container(
                          width: 16,
                          height: 10,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 235,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Transform.rotate(
                      angle: -45 * math.pi / 45,
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    mapController.move(selectedLocation, 15);
                    getAddress(selectedLocation);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.my_location_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Lokasi Saya",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              right: 0,
              left: 0,
              top: 0,
              bottom: 28,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 12,
                    left: 12,
                    top: 12,
                    bottom: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pilih Lokasi Kejadian/Laporan',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(40),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.secondary),
                            const SizedBox(width: 8),

                            if (isLoading)
                              Text(
                                "Mencari Alamat...",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            else
                              Expanded(
                                child: Text(
                                  alamat,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                Divider(color: Colors.black.withAlpha(20)),
                const SizedBox(height: 8),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.primary,
                        ),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              Navigator.pop(context, {
                                'latitude': selectedLocation.latitude,
                                'longitude': selectedLocation.longitude,
                                'alamat': alamat,
                              });
                            },
                      child: Text(
                        'Simpan',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<ui.Path> {
  @override
  ui.Path getClip(Size size) {
    final path = ui.Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<ui.Path> oldClipper) {
    return false;
  }
}
