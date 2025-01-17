import 'package:bloc/bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);  // Initial state is 0 (the first page)

  // This method is used to update the page
  void updatePage(int page) {
    emit(page);  // Emit the new page index as the state
  }
}
