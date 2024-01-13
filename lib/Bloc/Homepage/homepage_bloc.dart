import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soiscan/Models/user.dart';
import 'package:soiscan/Repositories/authentication_repository.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  HomepageBloc() : super(HomepageInitial()) {
    on<LoadHomepage>((event, emit) async {
      emit(HomepageLoading());
      // Get Users
      final User user = await _authenticationRepository.getUser();

      emit(HomepageLoaded(user: user));
    });
  }
}
