import 'package:acuteflow/features/decision_tree/data/models/remedy_model.dart';

abstract class RemedyRepository {
  Future<RemedyModel?> getRemedyById(String id);

  Future<List<RemedyModel>> getAllRemedies();

  Future<List<RemedyModel>> searchRemedies(String query);
}
