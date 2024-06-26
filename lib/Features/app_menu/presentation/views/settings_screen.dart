import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:team/Features/app_menu/presentation/widgets/settings_screen/settings_screen_body.dart';
import 'package:team/Features/app_menu/presentation/user_actions_cubit/user_actions_cubit.dart';
import 'package:team/Features/user_authentication/presentation/views/login_screen.dart';
import 'package:team/core/utils/medi_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserActionsCubit, UserActionsState>(
      listener: (context, state) {
        if (state is UserDeleteAccountSuccess) {
          Get.offAll(() => const LoginScreen());
        }
        if (state is UserDeleteAccountLoading) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.scale,
            title: "Delete Account",
            desc: state.message,
            btnOkOnPress: () {
              BlocProvider.of<UserActionsCubit>(context).userAcceptedDelete();
            },
            btnCancelOnPress: () {
              BlocProvider.of<UserActionsCubit>(context).setInitialState();
            },
            btnOkColor: Colors.red,
            btnCancelColor: MediColors.primaryColor,
          ).show();
        }
        if (state is UserActionsSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Success',
            desc: state.message,
            btnOkOnPress: () {
              BlocProvider.of<UserActionsCubit>(context).setInitialState();
            },
            btnOkIcon: Icons.check_circle,
            btnOkColor: Colors.green,
          ).show();
        }
        if (state is UserActionsFailure) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'Error',
            desc: state.error,
            btnOkOnPress: () {
              BlocProvider.of<UserActionsCubit>(context).setInitialState();
            },
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UserActionsLoading,
          progressIndicator: const CircularProgressIndicator(),
          color: MediColors.thirdColor,
          child: Scaffold(
              appBar: AppBar(
                title: const Text("Settings"),
                centerTitle: true,
              ),
              body: const SafeArea(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SettingsScreenBody(),
              ))),
        );
      },
    );
  }
}
