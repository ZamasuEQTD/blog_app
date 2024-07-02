import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';

import '../../../../shared_kernel/failure.dart';

abstract class FuenteDeArchivo {
  bool get isNetwork => this is NetworkMedia;
  bool get isLocal => this is LocalFile;
  bool get isMemory => this is MemoryFile;
}

class LocalFile extends FuenteDeArchivo {
  final File file;

  LocalFile(this.file);
}

class NetworkMedia extends FuenteDeArchivo {
  final String url;

  NetworkMedia(this.url);
}

class MemoryFile extends FuenteDeArchivo {
  final Uint8List bytes;

  MemoryFile(this.bytes);
}
