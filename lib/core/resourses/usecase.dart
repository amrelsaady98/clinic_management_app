abstract class Usecase<Type, Params> {
  const Usecase();
  Future<Type> call({Params params});
}
