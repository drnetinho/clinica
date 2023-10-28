import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class DoctorWidget extends StatefulWidget {
  final String name;
  final String specialty;
  final String? photo;
  final VoidCallback? onDeleteDoctor;
  final VoidCallback? onEditDoctor;

  const DoctorWidget({
    super.key,
    required this.name,
    required this.specialty,
    this.photo,
    this.onDeleteDoctor,
    this.onEditDoctor,
  });

  @override
  State<DoctorWidget> createState() => _DoctorWidgetState();
}

class _DoctorWidgetState extends State<DoctorWidget> {
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(10),
      color: context.colorsApp.dartMedium,
      elevation: 5,
      child: SizedBox(
        height: 130,
        width: 480,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: widget.photo != null || widget.photo!.isNotEmpty,
                replacement: const CircleAvatar(radius: 40),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: CachedNetworkImageProvider(widget.photo!),
                ),
              ),
              const SizedBox(width: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: context.textStyles.textPoppinsSemiBold
                        .copyWith(color: context.colorsApp.blackColor)
                        .copyWith(fontSize: 22),
                  ),
                  Text(
                    widget.specialty,
                    style: context.textStyles.textPoppinsRegular
                        .copyWith(color: context.colorsApp.blackColor)
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
              const Spacer(),
              PopupMenuButton<int>(
                icon: Icon(Icons.more_vert_outlined, color: context.colorsApp.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 2,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: context.colorsApp.danger,
                          ),
                          Text(
                            'Deletar',
                            style: TextStyle(
                              color: context.colorsApp.danger,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: context.colorsApp.success,
                          ),
                          Text(
                            'Editar',
                            style: TextStyle(
                              color: context.colorsApp.success,
                            ),
                          ),
                        ],
                      ),
                    )
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    widget.onDeleteDoctor?.call();
                  }
                  if (value == 1) {
                    widget.onEditDoctor?.call();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
