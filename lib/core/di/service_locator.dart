import 'package:get_it/get_it.dart';
import 'package:test_ecommerce/modules/home/respository/home_repository.dart';
import 'package:test_ecommerce/modules/products/repository/products_repository.dart';
import '../../modules/categories/repository/categories_repository.dart';
import '../network/dio_client.dart';

final sl = GetIt.instance;

void setupLocator() async {
  /// ==================== Networking ===========================
  sl.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: 'https://dummyjson.com/'));

  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepository(dioClient: sl()));
  sl.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepository(dioClient: sl())); sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepository(dioClient: sl()));
}
