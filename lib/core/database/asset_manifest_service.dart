import 'dart:convert';
import 'package:flutter/services.dart';

class AssetManifestService {
  Future<List<dynamic>> loadRawRemedies() async {
    final String content = await rootBundle.loadString('assets/data/remedy_details.json');
    final Map<String, dynamic> decoded = jsonDecode(content);
    return decoded['remedies'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> loadRawDecisionTree() async {
    final String content = await rootBundle.loadString('assets/data/decision_tree.json');
    final Map<String, dynamic> decoded = jsonDecode(content);
    return decoded['decision_tree'] as Map<String, dynamic>;
  }
}