import 'package:flutter/material.dart';
import '../atoms/custom_button.dart';
import '../atoms/custom_text.dart';
import '../atoms/custom_toggle.dart';
import '../atoms/date_picker_input.dart';
import '../atoms/input_field.dart';

class ContainerNotiStatic extends StatefulWidget {

  final TextEditingController titleCtrl;
  final TextEditingController messageCtrl;
  final TextEditingController timeCtrl;
  final VoidCallback registerPressed;
  final VoidCallback demoPressed;
  final VoidCallback deletePressed;
  final int? selectedRepeat;
  final Function(int) onPressed;



  const ContainerNotiStatic({super.key, required this.titleCtrl, required this.messageCtrl, required this.timeCtrl, required this.registerPressed, required this.demoPressed, required this.deletePressed, required this.selectedRepeat, required this.onPressed});

  @override
  State<ContainerNotiStatic> createState() => _ContainerNotiStaticState();
}

class _ContainerNotiStaticState extends State<ContainerNotiStatic> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Color.fromRGBO(241,241,241, 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomButton(text: 'Vista previa', onPressed: widget.demoPressed),
                    ]
                  ),
                ),
                CustomText(text: 'Titulo', fontSize: 15),
                InputField(label: 'Ingrese el titulo de la notificación', controller: widget.titleCtrl, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                CustomText(text: 'Recordatorio', fontSize: 15),
                InputField(label: 'Ingrese el recordatorio de la notificación', controller: widget.messageCtrl, keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                CustomText(text: 'Fecha', fontSize: 15),
                DatePickerInput(label: 'dd/mm/yyyy hh:mm', controller: widget.timeCtrl),
                const SizedBox(height: 10),
                CustomText(
                  text: 'Opcional: seleccione si desea repetir la notificación',
                  fontSize: 15,
                ),
                const SizedBox(height: 10),
                Center(
                  child: CustomToggle(
                    selectedRepeat: widget.selectedRepeat,
                    onPressed: widget.onPressed
                  )
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(text: 'Guardar', onPressed: widget.registerPressed, color: Color(0xFF2E7D32),),
                      CustomButton(text: 'Cancelar', onPressed: widget.deletePressed, color: Color(0xFFD32F2F))

                    ],
                  )
                ),
              ],
            ),
          ),
        )
    );
  }
}
