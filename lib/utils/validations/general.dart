import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Validator {

  static String? validateFullname(String value) {

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    RegExp regex = RegExp(r"^[A-zÀ-Ÿ][A-zÀ-ÿ']+\s([A-zÀ-ÿ']\s?)*[A-zÀ-Ÿ][A-zÀ-ÿ']+$");

    if (!regex.hasMatch(value.trim()))
      return 'Este campo deve possuir no minímo dois nomes e iniciar com letras maiúsculas';

    return null;
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!regex.hasMatch(value.trim()))
      return 'Digite um e-mail válido';

    return null;
  }

  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    RegExp regex = RegExp(r'^(?=.{2,30}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');

    if (!regex.hasMatch(value.trim()))
      return 'Usuário deve conter 2 a 30 caracteres, e não deve possuir caracteres especiais';

    return null;
  }

  static String? validatePassword(String password, {int minLength = 6}) {
    if (password.isEmpty) {
      return "Campo obrigatório";
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= minLength;

    if(!hasUppercase) {
      return "Senha deve conter no mínimo uma letra maiúscula";
    }

    if(!hasLowercase) {
      return "Senha deve conter no mínimo uma letra minúscula";
    }

    if(!hasMinLength) {
      return "Senha deve ser maior que 6 carateres";
    }

    if(!hasDigits) {
      return "Senha deve conter no mínimo um número";
    }

    if(!hasSpecialCharacters) {
      return "Senha deve conter no mínimo um caractere especial";
    }

    return null;
  }

  static String? validateLength(String password, {int minLength = 6}) {
    if (password.isEmpty) {
      return "Campo obrigatório";
    }

    bool hasMinLength = password.length >= minLength;

    if(!hasMinLength) {
      return "Senha deve ser maior que 6 caracteres";
    }

    return null;
  }

  static String? validatePhone(String value) {

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    RegExp regex = RegExp(r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$');

    if (!regex.hasMatch(value.trim())) {
      return 'Telefone possui formato inválido';
    }

    return null;
  }

  static String? validateCref(String value) {

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    RegExp regex = RegExp(r'^([0-9]){6}\-([A-Z])\/([A-Z]){2}');

    if (!regex.hasMatch(value.trim()))
      return 'CREF possui formato inválido';

    return null;
  }

  static String? validateDuration(String value) {

    if (value.isEmpty)
      return 'Campo obrigatório';

    if(int.tryParse(value) == null)
      return 'Valor digitado não é númerico';

    var valueInt = int.parse(value.trim());

    if (valueInt > 24)
      return 'Duração não pode ser maior que 24';

    if (valueInt < 0)
      return 'Duração não pode ser menor que 0';

    return null;
  }

  static String? validateSimple(String value) {

    if (value.length == 0)
      return 'Campo obrigatório';

    return null;
  }

  static String? validateCompare(String oldPassword, String newPassword) {

    if (newPassword.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }
  static String? validateCompareNumber(String oldPassword, String newPassword) {

    if (newPassword.isEmpty)
      return 'Campo obrigatório';

    if(oldPassword != newPassword)
      return 'Campos não coincidem';

    return null;
  }


  static String? oldNumber(String oldPassword, String newPassword) {

    if (newPassword.isEmpty)
      return 'Campo obrigatório';

    if(oldPassword == newPassword)
      return 'Novo número igual número atual';

    return null;
  }

  static String? oldPassword(String oldPassword, String newPassword) {

    if (newPassword.isEmpty)
      return 'Campo obrigatório';

    if(oldPassword == newPassword)
      return 'Nova senha igual senha atual';

    return null;
  }
  static String? cep(String cep,) {
    var maskcep = MaskTextInputFormatter(mask: "#####-###");
    if (cep.isEmpty)
      return 'Campo obrigatório';

    if(cep == maskcep)
      return 'Nova senha igual senha atual';

    return null;
  }
  static int? calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}