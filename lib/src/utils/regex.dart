class RegExpIsValide {
  final isValidPhone = RegExp(r"^\+?0[0-9]{10}$");
  final isValidEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final isValidPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final isValidName =RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");

  final isValideVente = RegExp(r"^\d{10}$");
}
