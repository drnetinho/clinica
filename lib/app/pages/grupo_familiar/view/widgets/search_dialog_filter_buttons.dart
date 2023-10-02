import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/helps/spacing.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class SearchDialogFilterButtons extends StatelessWidget {
  final bool groupIsSelected;
  final Function(bool) onChanged;

  const SearchDialogFilterButtons({
    Key? key,
    required this.groupIsSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 46,
            width: 110,
            child: ElevatedButton(
              onPressed: () {
                if (!groupIsSelected) {
                  onChanged.call(true);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: groupIsSelected ? context.colorsApp.whiteColor : context.colorsApp.dartMedium,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: groupIsSelected ? context.colorsApp.primary : context.colorsApp.whiteColor),
                ),
              ),
              child: Text(
                'Grupo',
                style: context.textStyles.textPoppinsSemiBold
                    .copyWith(color: groupIsSelected ? context.colorsApp.blackColor : context.colorsApp.greyColor),
              ),
            ),
          ),
          Spacing.m.horizotalGap,
          SizedBox(
            height: 46,
            width: 110,
            child: ElevatedButton(
              onPressed: () {
                if (groupIsSelected) {
                  onChanged.call(false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: !groupIsSelected ? context.colorsApp.whiteColor : context.colorsApp.dartMedium,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: !groupIsSelected ? context.colorsApp.primary : context.colorsApp.whiteColor),
                ),
              ),
              child: Text(
                'Paciente',
                style: context.textStyles.textPoppinsSemiBold
                    .copyWith(color: !groupIsSelected ? context.colorsApp.blackColor : context.colorsApp.greyColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
