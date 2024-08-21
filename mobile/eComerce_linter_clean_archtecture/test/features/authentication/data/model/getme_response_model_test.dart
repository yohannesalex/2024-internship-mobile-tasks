import 'package:flutter_test/flutter_test.dart';
import 'package:my_project_name/features/authentication/data/model/get_me_response_model.dart';
import 'package:my_project_name/features/authentication/domain/entity/getme_entity.dart';

void main() {
  const testGetMeModel = GetMeResponseModel(
    name: 'john',
  );
  const testGetMeEntity = GetMeEntity(
    name: 'john',
  );
  test('should be a subclass of login entity', () async {
    expect(testGetMeModel, isA<GetMeEntity>());
  });
  test('should be return a correct Json model', () async {
    final result = GetMeResponseModel.toModel(testGetMeEntity);
    expect(result, testGetMeModel);
  });
}
