import 'package:get_it/get_it.dart';

import 'abstractions/istrategy_context.dart';

class StrategyContext extends IStrategyContext {
  @override
  Future<TOut> execute<TIn, TOut, TStrategy extends IStrategy<TIn, TOut>>(
    String key,
    TIn model,
  ) {
    TStrategy strategy = GetIt.I.get(instanceName: key);

    return strategy.execute(model);
  }
}
