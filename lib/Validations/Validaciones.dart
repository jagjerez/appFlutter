
class Validaciones{

    String loginValidation(value){
    if(value.isEmpty){
      return 'Please enter some text';
    }
    return null;
  }
}