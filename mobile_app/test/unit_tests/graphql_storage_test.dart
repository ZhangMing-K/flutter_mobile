// import 'package:flutter_test/flutter_test.dart';
// import 'package:iris_mobile/app/data/providers/local/iris_cache/impl/iris_cache_impl.dart';
// import 'package:iris_mobile/app/data/providers/local/iris_cache/interface/iris_cache_interface.dart';
// import 'package:iris_mobile/app/data/providers/local/iris_cache/iris_cache.dart';
// import 'package:iris_mobile/app/data/providers/local/secure_storage/secure_storage_mock.dart';
// import 'package:iris_mobile/app/data/providers/local/storage/storage.dart';

// void main() {
//   late IStorage database;
//   late IrisCacheInterface graphQLCacheStorage;
//   setUp(() async {
//     final storage = SecureStorageMock();

//     database = StorageMock(secure: storage);
//     graphQLCacheStorage = IrisCache(storage: database);
//     await database.init();
//   });

//   tearDown(() {
//     database.reset();
//   });

//   test('Test the graphqlStorage cache when no data is available', () {
//     expect(graphQLCacheStorage.getCacheResult('key'), null);
//   });

//   test('Test the graphqlStorage cache when data was fetched previosly', () {
//     graphQLCacheStorage.putOnCache('key', CacheEntry(id: 'foo', data: 'bar'));
//     expect(graphQLCacheStorage.getFromCache('key', 'foo'), 'bar');
//   });

//   test('Test the graphqlStorage with multiple data', () {
//     graphQLCacheStorage.putOnCache('key', CacheEntry(id: 'foo', data: 'bar'));
//     graphQLCacheStorage.putOnCache('key', CacheEntry(id: 'foo2', data: 'bar2'));
//     graphQLCacheStorage.putOnCache('key', CacheEntry(id: 'foo3', data: 'bar3'));
//     expect(graphQLCacheStorage.getFromCache('key', 'foo'), 'bar');
//     expect(graphQLCacheStorage.getFromCache('key', 'foo2'), 'bar2');
//     expect(graphQLCacheStorage.getFromCache('key', 'foo3'), 'bar3');
//   });
// }
