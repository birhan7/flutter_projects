import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnection])
void main(){
  late NetworkInfoImpl networkInfo;
  late MockInternetConnection internetConnection;

  setUp((){
    internetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(internetConnection);
  });

  group('Network Connection', (){
    test('should forward the call to InternetConnection().hasInternetAccess() method', () async {
      // arrange
      when(internetConnection.hasInternetAccess).thenAnswer((_) async => true);
      // act
      final result = await networkInfo.isConnected;
      // assert
      verify(internetConnection.hasInternetAccess);
      expect(result, true);
    });
  });
  
}