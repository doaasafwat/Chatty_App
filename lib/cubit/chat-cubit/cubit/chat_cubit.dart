import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference Messages =
      FirebaseFirestore.instance.collection(KMessages);
  List<Message> MessagesList = [];
  void sendMessage({required String message, required String email}) {
    Messages.add(
      {
        KMess: message,
        KCreatedAt: DateTime.now(),
        'id': email,
      },
    );
  }

  void getMessage() {
    Messages.orderBy(KCreatedAt, descending: true).snapshots().listen((event) {
      MessagesList.clear();
      for (var doc in event.docs) {
        MessagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messagesList: MessagesList));
    });
  }
}
