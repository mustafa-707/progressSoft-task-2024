import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progressofttask/logic/cubit/config/states.dart';
import 'package:progressofttask/logic/firebase/firebase_collections.dart';
import 'package:progressofttask/logic/firebase/firestore.dart';
import 'package:progressofttask/models/config.dart';

class ConfigCubit extends Cubit<ConfigStates> {
  ConfigCubit() : super(ConfigInitState()) {
    init();
  }

  static ConfigCubit get(context) => BlocProvider.of<ConfigCubit>(context);
  static const Config _fallbackConfig = Config(
    delay: 2,
    regex: FieldRegex(
      mobile: [
        RegexInfo(
          ar: 'رقم الهاتف غير صحيح',
          en: 'Mobile number is incorrect',
          value: r'^\+[1-9]\d{1,14}$',
        ),
      ],
      password: [
        RegexInfo(
          ar: '8 أحرف على الأقل',
          en: 'At least 8 characters long',
          value: r'^.{8,}$',
        ),
        RegexInfo(
          ar: 'أقلها حرف واحد كبير',
          en: 'At least one uppercase letter',
          value: r'^(?=.*[A-Z]).+$',
        ),
      ],
      fullName: [
        RegexInfo(
          ar: 'الاسم غير صحيح',
          en: 'Name is incorrect',
          value: r'\s*([A-Za-z]+(\s+[A-Za-z]+)+)\s',
        ),
      ],
    ),
    countries: ["JO"],
  );

  late FireStoreService<Config> firestore;
  Config config = _fallbackConfig;
  void init() {
    firestore = FireStoreService<Config>(
      path: FirebaseCollections.config,
      fromJsonT: (d) => Config.fromJson(d),
      toJsonT: (c) => c.toJson(),
    );
  }

  Future<void> fetchConfig() async {
    final config = await firestore.get();
    if (config == null) throw Exception('Config not found');
    this.config = config.first;
    emit(ConfigLoadedState());
  }
}
