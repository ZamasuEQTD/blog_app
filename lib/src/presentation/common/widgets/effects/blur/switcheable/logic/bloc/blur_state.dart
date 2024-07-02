part of 'blur_bloc.dart';

sealed class BlurState extends Equatable {
  const BlurState();
  bool get blurear => this is Blureable;
  @override
  List<Object> get props => [];
}

final class NoBlureable extends BlurState {}

final class Blureable extends BlurState {}

