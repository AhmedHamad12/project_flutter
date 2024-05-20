import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/autho/registration/controller/registration_cubit.dart';
import 'package:project/features/autho/registration/view/components/bottom_widget.dart';
import 'package:project/features/autho/registration/view/components/data_widget.dart';
class RegestrationPage extends StatelessWidget {
  const RegestrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationCubit>(
      create: (context) => RegistrationCubit(),
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
          RegistrationCubit controller = context.read<RegistrationCubit>();
          return Scaffold(
            
            body: Container(
             color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: CircleAvatar(
                                      radius: 53,
                                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                      child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/logo.jpeg'),
                                      ),
                                    ),
                    ),
                    DataWidget(
                      controller: controller,
                    ),
                 SizedBox(height: 40,)
           , Container(
              
              child: BottomNavigationWidget(
                controller: controller,
              ),
            ),
           
           
           
             ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
