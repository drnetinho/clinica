import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

class StateErrorWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? refresh;
  const StateErrorWidget({
    Key? key,
    this.message,
    this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.error_outline_outlined),
          Text(message ?? 'Erro ao buscar os dados'),
          if (refresh != null) ...{
            CupertinoButton(
              onPressed: refresh,
              child: const Text('Recarregar'),
            ),
          },
        ],
      ),
    );
  }
}

class StateEmptyWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  const StateEmptyWidget({
    Key? key,
    this.message,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.info,
            size: 24,
            color: ColorsApp.instance.warning,
          ),
          Text(
            message ?? 'Nenhum dado encontrado',
            style: context.textStyles.textPoppinsMedium.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class StateInitialWidget extends StatelessWidget {
  const StateInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class StateLoadingWidget extends StatelessWidget {
  final Color? spinnerColor;
  final double? size;
  const StateLoadingWidget({
    Key? key,
    this.spinnerColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: spinnerColor ?? ColorsApp.instance.success,
        ),
      ),
    );
  }
}
