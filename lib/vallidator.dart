abstract class Stringvallidator {
  bool isvalid(String value);
}


class NonEmtystringvallidator implements Stringvallidator {
  @override
  bool isvalid(String value) {
    return value.isNotEmpty;
    throw UnimplementedError();
  }

}

class EmailandpasswordVallidators {
  final Stringvallidator emailvallidator = NonEmtystringvallidator();
  final Stringvallidator passvallidator = NonEmtystringvallidator();
  String errorpass = 'password can/t be invalid';
  String erroremail = 'email can/t be invalid';


}