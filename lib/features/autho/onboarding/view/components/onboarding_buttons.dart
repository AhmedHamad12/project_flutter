import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/autho/onboarding/controller/cubit/onboarding_controller_cubit.dart';

class OnBoardingButtons extends StatelessWidget {
  const OnBoardingButtons({super.key, required this.controller});
  final OnboardingControllerCubit controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => controller,
      child: BlocBuilder<OnboardingControllerCubit, OnboardingControllerState>(
        builder: (context, state) {
          final controller = context.read<OnboardingControllerCubit>();

          return SizedBox(
            height: 100,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.onCallSkip(context),
                      child: const Text("Skip",style: TextStyle(color:Color(0xff275282)),)),
                  TextButton(
                      onPressed: controller.onChangeToNext,
                      child: const Text("Next",style:TextStyle(color:Color(0xff275282)))
          )]),
          );
        },
      ),
    );
  }
}
