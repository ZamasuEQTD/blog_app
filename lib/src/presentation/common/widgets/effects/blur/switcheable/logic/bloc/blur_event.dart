part of 'blur_bloc.dart';

sealed class BlurEvent extends Equatable {
  const BlurEvent();

  @override
  List<Object> get props => [];
}

final class SwitchBlur extends BlurEvent {}