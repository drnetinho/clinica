import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/widgets/doctor_widget.dart';
import 'package:netinhoappclinica/app/pages/doctors/view/widgets/new_doctors_buttom_widget.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class DoctorsPage extends StatefulWidget {
  static const String routeName = '/doctors';
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO - FALTA IMPLEMENTAR A API
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gerenciar Médicos',
              style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 36),
            ),
            const SizedBox(height: 20),
            NewDoctorsButtom(
              onPressed: () {},
            ),
            const SizedBox(height: 60),
            const DoctorWidget(
              name: 'Dr. Netinho',
              specialty: 'Cardiologista',
              photo: 'https://avatars.githubusercontent.com/u/60005589?v=4',
            ),
          ],
        ),
      ),
    );
  }
}
