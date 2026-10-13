import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_form_options.dart';
import 'package:desa_digital/features/profil/presentation/controllers/profile_controller.dart';
import 'package:desa_digital/features/profil/presentation/widgets/main_info_form.dart';
import 'package:desa_digital/features/profil/presentation/widgets/personal_data_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class UbahProfilScreen extends StatefulWidget {
  const UbahProfilScreen({super.key});

  @override
  State<UbahProfilScreen> createState() => _UbahProfilScreenState();
}

class _UbahProfilScreenState extends State<UbahProfilScreen>
    with SingleTickerProviderStateMixin {
  ProfileController get _controller => Get.find<ProfileController>();

  final TextEditingController _dateController = TextEditingController();
  late TabController _tabController;

  final Map<String, ValueNotifier<String?>> _dropdownValues = {};

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(_onTabChanged);
    _controller.resetForm();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _dateController.dispose();
    for (final notifier in _dropdownValues.values) {
      notifier.dispose();
    }
    super.dispose();
  }

  ProfileFormOptions get _options =>
      _controller.formOptions.value ??
      const ProfileFormOptions(
        religion: [],
        marriedStatus: [],
        provinsi: [],
        kabupaten: [],
        kecamatan: [],
        kelurahan: [],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Ubah Informasi Pribadi",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          bottom: TabBar(
            controller: _tabController,
            dividerColor: AppColors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelStyle: TextStyle(
              color: AppColors.grey,
              fontSize: 14,
            ),
            labelPadding: EdgeInsets.only(bottom: 12, top: 12),
            indicatorColor: AppColors.secondary,
            labelColor: AppColors.secondary,
            overlayColor: WidgetStatePropertyAll(
              AppColors.secondary.withAlpha(40),
            ),

            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Text("Data Profil", style: TextStyle(fontSize: 14)),
              Text("Data Diri", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),

                  CircleAvatar(
                    backgroundColor: AppColors.primary.withAlpha(40),
                    radius: 45,
                    child: Icon(
                      Iconsax.user,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                  MainInfoForm(
                    fullNameController: _controller.fullNameController,
                    emailController: _controller.emailController,
                    phoneController: _controller.phoneController,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () => PersonalDataForm(
                    onSimpan: () {},
                    dateController: _dateController,
                    pickDate: _pickDate,
                    selectedGender: _controller.selectedGender.value,
                    onGenderChanged: _controller.selectGender,
                    religionItems: _options.religion,
                    marriedStatus: _options.marriedStatus,
                    provinsiItems: _options.provinsi,
                    kabupatenItems: _options.kabupaten,
                    kecamatanItems: _options.kecamatan,
                    kelurahanItems: _options.kelurahan,
                    fullNameController: _controller.fullNameController,
                    emailController: _controller.emailController,
                    phoneController: _controller.phoneController,
                    dropdownValues: _dropdownValues,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
