abstract class IStrategyContext {
  Future<TOut> execute<TIn, TOut, TStrategy extends IStrategy<TIn, TOut>>(
    String key,
    TIn model,
  );
}

abstract class IStrategy<TIn, TOut> {
  Future<TOut> execute(TIn input);
}
