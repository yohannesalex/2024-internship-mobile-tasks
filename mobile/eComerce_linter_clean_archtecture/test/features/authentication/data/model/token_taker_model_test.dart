import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_project_name/features/authentication/data/model/token_taker_model.dart';

import '../../../../helpers/read_json.dart';

void main() {
  const testTokenTakerModel = TokenTakerModel(
      token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZ21haWwuY29tIiwiaWF0IjoxNzIzNzIwNTk3LCJleHAiOjE3MjQxNTI1OTd9.Mz9mIyOPHgyONb3bLvDO9N2wwF562Xb4nQnJEhtV3Fk');
  test('should return the valid model from the json', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_login_response.json'));
    final result = TokenTakerModel.fromJson(jsonMap);
    expect(testTokenTakerModel, result);
  });
}
