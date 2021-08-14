import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eshop/data/login/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());
  final LoginRepo _repo=LoginRepo();
  StreamSubscription subscription;

  String verID = "";
  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();
      subscription = sendOtp(event.phoNo).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        final User result =
        await _repo.verifyAndLogin(verID, event.otp);
        if (result != null) {
          yield LoginCompleteState(result);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        print(e);
      }
    }
  }

  Stream<LoginEvent> sendOtp(String phoNo) async* {

    print(phoNo);
    final StreamController<LoginEvent> eventStream = StreamController();
    PhoneVerificationCompleted verified (AuthCredential authCredential) {
      print("executing");
      print(_repo.auth.currentUser);
      if(_repo.auth.currentUser==null){
        eventStream.add(LoginCompleteEvent(_repo.auth.currentUser));
        eventStream.close();
      }
      return null;
    }
    PhoneVerificationFailed exception(FirebaseAuthException authException) {
      print("wrong");
      print("error: +$authException");
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
      return null;
    }
    PhoneCodeSent codeSent(String verId, [int forceResent]) {
      verID = verId;
      eventStream.add(OtpSendEvent());
      return null;
    }
    PhoneCodeAutoRetrievalTimeout timeout(String verid) {
      verID = verid;
      eventStream.close();
      return null;
    }

     _repo.sendOtp(
        phoNo,
        exception,
        verified,
        codeSent,
        timeout
    );

    yield* eventStream.stream;
  }
}
