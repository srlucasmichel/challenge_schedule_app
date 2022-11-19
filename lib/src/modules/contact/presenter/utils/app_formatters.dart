import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppMaskFormatters {
  static final MaskTextInputFormatter phone = MaskTextInputFormatter(
      mask: '+## (##) #########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static final MaskTextInputFormatter cpf = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
