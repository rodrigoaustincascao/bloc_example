import 'package:bloc_example/models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactsRepository {
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('http://10.0.2.2:3031/contacts');

    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

  Future<void> create(ContactModel contact) async {
    await Dio().post('http://10.0.2.2:3031/contacts', data: contact.toMap());
  }

  Future<void> update(ContactModel contact) async {
    await Dio().put(
      'http://10.0.2.2:3031/contacts/${contact.id}',
      data: contact.toMap(),
    );
  }

  Future<void> delete(ContactModel contact) async {
    await Dio().delete('http://10.0.2.2:3031/contacts/${contact.id}');
  }
}
