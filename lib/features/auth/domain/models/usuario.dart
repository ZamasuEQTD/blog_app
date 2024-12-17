// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String usuario;
  final HashSet<Roles> roles;
  const Usuario({
    required this.usuario,
    required this.roles,
  });

  bool get isModerador => roles.contains(Roles.moderador);

  factory Usuario.formJson(Map<String, dynamic> json) {
    return Usuario(
      usuario: json["name"],
      roles: HashSet.from(
        json["roles"] ??
            []
                .map(
                  (e) =>
                      Roles.values.firstWhere((element) => element.name == e),
                )
                .toList(),
      ),
    );
  }
  @override
  List<Object?> get props => throw UnimplementedError();
}

enum Roles {
  anonimo,
  moderador,
}
