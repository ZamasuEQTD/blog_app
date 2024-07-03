import 'icommand.dart';

abstract class ICommandHandler<TCommand extends ICommand<TResponse>, TResponse>  {
  const ICommandHandler();
  
  Future<TResponse> handle(TCommand command);
}