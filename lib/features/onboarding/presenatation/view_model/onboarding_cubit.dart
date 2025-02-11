import 'package:bloc/bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);  // Initial page is 0

  void updatePage(int page) {
    if (page >= 0 && page <= 3) {
      emit(page);
    }
  }
}
