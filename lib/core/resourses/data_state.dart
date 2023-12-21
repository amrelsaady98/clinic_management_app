import 'package:dio/dio.dart';

abstract class DataState<T> {
  T? data;
  DioException? error;

  DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T? data) : super(data: data);
}

class DataFialed<T> extends DataState<T> {
  DataFialed(DioException? error) : super(error: error);
}
