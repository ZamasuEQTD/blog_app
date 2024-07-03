
import 'iquery.dart';

abstract class IQueryHandler<TQuery extends IQuery<TResponse>, TResponse> {
  const IQueryHandler();

  Future<TResponse> handle(TQuery request);
}
