import 'package:bloc/bloc.dart';
import 'package:bloc_example/models/contact_model.dart';
import 'package:bloc_example/repositories/contacts_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_list_event.dart';

part 'contact_list_bloc.freezed.dart';

part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  ContactsRepository _repository;

  ContactListBloc({required ContactsRepository repository})
    : _repository = repository,
      super(ContactListState.initial()) {
    on<_ContactListEventFindAll>(_findAll);
  }

  Future<void> _findAll(
    _ContactListEventFindAll event,
    Emitter<ContactListState> emit,
  ) async {
    final contacts = await _repository.findAll();
    emit(ContactListState.data(contacts: contacts));
  }
}
