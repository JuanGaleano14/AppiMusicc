import 'package:alarmfy/src/models/authorization_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthorizationBloc {
  final _repository = RepositoryAuthorization();

  final PublishSubject _authorizationTokenFetcher = PublishSubject<AuthorizationModel>();
  final PublishSubject _authorizationCodeFetcher = PublishSubject<String>();

  Observable<String> get authorizationCode => _authorizationCodeFetcher.stream;
  Observable<AuthorizationModel> get authorizationToken => _authorizationTokenFetcher.stream;

  // ignore: always_declare_return_types
  fetchAuthorizationCode() async {
    var code = await _repository.fetchAuthorizationCode();
    _authorizationCodeFetcher.sink.add(code);
  }

  fetchAuthorizationToken(String code) async {
    var authorizationModel = await _repository.fetchAuthorizationToken(code);
    _authorizationTokenFetcher.sink.add(authorizationModel);
  }

  // ignore: always_declare_return_types
  disposeCode() {
    _authorizationCodeFetcher.close();
  }

  // ignore: always_declare_return_types
  disposeToken() {
    _authorizationTokenFetcher.close();
  }
}

final AuthorizationBloc authorizationBloc = AuthorizationBloc();