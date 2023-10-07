import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class DoctorWidget extends StatelessWidget {
  final String name;
  final String specialty;
  final String? photo;

  const DoctorWidget({
    super.key,
    required this.name,
    required this.specialty,
    this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 480,
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(10),
        color: context.colorsApp.dartMedium,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: photo != null || photo!.isNotEmpty,
                replacement: const CircleAvatar(radius: 40),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(photo!),
                ),
              ),
              const SizedBox(width: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(color: context.colorsApp.blackColor)
                        .copyWith(fontSize: 22),
                  ),
                  Text(
                    specialty,
                    style: context.textStyles.textPoppinsRegular
                        .copyWith(color: context.colorsApp.blackColor)
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
                color: context.colorsApp.blackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
