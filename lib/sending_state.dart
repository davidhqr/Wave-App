class SendingState {
  static final SendingState _sendingState = new SendingState._internal();

  factory SendingState() {
    return _sendingState;
  }

  bool sending;
  DateTime time;

  SendingState._internal() {
    sending = false;
  }
}