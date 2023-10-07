import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/edit_medical_scale/widgets/new_scale_buttom.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class EditMedicalScale extends StatefulWidget {
  static const String routeName = '/edit_medical_scale';
  const EditMedicalScale({super.key});

  @override
  State<EditMedicalScale> createState() => _EditMedicalScaleState();
}

class _EditMedicalScaleState extends State<EditMedicalScale> {
  @override
  Widget build(BuildContext context) {
    // TODO - FALTA IMPLEMENTAR A API
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Editar Escala Médica',
              style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 36),
            ),
            const SizedBox(height: 20),
            NewScaleButtom(
              onPressed: () {},
            ),
            const SizedBox(height: 60),
            const DoctorCardScale(
                name: 'Dr. Netinho',
                specialty: 'Cardiologista',
                photo: 'https://avatars.githubusercontent.com/u/60005589?v=4'),
          ],
        ),
      ),
    );
  }
}


// TODO - FALTA IMPLEMENTAR O HORÁRIO E DATA
class DoctorCardScale extends StatelessWidget {
  final String name;
  final String specialty;
  final String photo;

  const DoctorCardScale({
    super.key,
    required this.name,
    required this.specialty,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 440,
      height: 190,
      child: PhysicalModel(
        color: ColorsApp.instance.dartMedium,
        borderRadius: BorderRadius.circular(20),
        elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: photo.isNotEmpty,
                    replacement: const CircleAvatar(radius: 40),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(photo),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: context.textStyles.textPoppinsSemiBold
                            .copyWith(color: context.colorsApp.blackColor)
                            .copyWith(fontSize: 18),
                      ),
                      Text(
                        specialty,
                        style: context.textStyles.textPoppinsRegular
                            .copyWith(color: context.colorsApp.greyColor2)
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colorsApp.dartWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, color: context.colorsApp.greyColor2, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Quinta, 13 junho',
                      style: context.textStyles.textPoppinsSemiBold
                          .copyWith(color: context.colorsApp.greyColor2, fontSize: 14),
                    ),
                    const SizedBox(width: 30),
                    Icon(Icons.access_alarm, color: context.colorsApp.greyColor2, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      '10:00' ' - ' '11:00',
                      style: context.textStyles.textPoppinsSemiBold
                          .copyWith(color: context.colorsApp.greyColor2, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
