import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/doctors/domain/model/doctor.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/store/doctor_store.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/store/edit_doctor_store.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/widgets/doctor_widget.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/widgets/new_doctor_dialog.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/widgets/new_doctors_buttom_widget.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/snackbar.dart';
import 'package:netinhoappclinica/core/components/store_builder.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';
import '../../../../../di/get_it.dart';

class DoctorsPage extends StatefulWidget {
  static const String routeName = '/doctors';
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> with SnackBarMixin {
  late final DoctorStore doctorStore;
  late final EditDoctorStore editDoctorStore;

  @override
  void initState() {
    super.initState();
    doctorStore = getIt<DoctorStore>();
    editDoctorStore = getIt<EditDoctorStore>();
    doctorStore.getDoctors();

    editDoctorStore.addListener(editDoctorStoreListener);
  }

  @override
  void dispose() {
    doctorStore.dispose();
    editDoctorStore.removeListener(editDoctorStoreListener);
    editDoctorStore.dispose();
    super.dispose();
  }

  void editDoctorStoreListener() {
    if (editDoctorStore.value.isSuccess) {
      doctorStore.getDoctors();
    } else if (editDoctorStore.value.isError) {
      showError(
        context: context,
        text: editDoctorStore.value.error.message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gerenciar Médicos',
                  style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 36),
                ),
                IconButton(
                  onPressed: () => doctorStore.getDoctors(),
                  tooltip: 'Recarregar Médicos',
                  icon: Icon(
                    Icons.refresh,
                    color: context.colorsApp.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            NewDoctorsButtom(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => NewDoctorDialog(
                    onConfirm: (doctor) => editDoctorStore.createDoctor(doctor),
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
            StoreBuilder<List<Doctor>>(
              store: doctorStore,
              builder: (context, List<Doctor> doctors, __) {
                return Wrap(
                  children: List.generate(
                    doctors.length,
                    (index) {
                      final doctor = doctors[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DoctorWidget(
                          name: doctor.name,
                          specialty: doctor.specialization,
                          photo: doctor.image,
                          onDeleteDoctor: () => editDoctorStore.deleteDoctor(doctor),
                          onEditDoctor: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => NewDoctorDialog(
                                doctor: doctor,
                                onConfirm: (doctor) => editDoctorStore.editDoctor(doctor),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
