// ignore_for_file: unused_element

import 'dart:collection';
import 'dart:io';

import 'package:blog_app/common/domain/services/horarios_service.dart';
import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/common/widgets/media/widgets/spoiler_media.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/features/encuestas/presentation/widgets/encuesta.dart';
import 'package:blog_app/features/home/presentation/widgets/portada/home_portada.dart';
import 'package:blog_app/features/media/domain/usecases/get_gallery_file_usecase.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:blog_app/features/media/presentation/widgets/media_box/media_box.dart';
import 'package:blog_app/features/media/presentation/widgets/miniatura/miniatura.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/effects/gradient/animated_gradient.dart';
import '../../../../common/widgets/inputs/decorations/decorations.dart';
import '../../../encuestas/domain/models/encuesta.dart';
import '../../domain/models/comentario.dart';
import '../../domain/models/hilo.dart';
import '../logic/bloc/hilo/comentar_hilo/comentar_hilo_bloc.dart';
import '../logic/bloc/hilo/hilo_bloc.dart';

import '../logic/controllers/taggueos_controller.dart';

class HiloScreen extends StatefulWidget {
  final HiloId id;
  const HiloScreen({super.key, required this.id});

  @override
  State<HiloScreen> createState() => _HiloScreenState();
}

class _HiloScreenState extends State<HiloScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaggueosController(),
      child: BlocProvider(
        create: (context) => ComentarHiloBloc(),
        child: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HiloBloc("")..add(CargarHilo()),
              ),
            ],
            child: BlocBuilder<HiloBloc, HiloState>(
              builder: (context, state) {
                switch (state.status) {
                  case HiloStatus.cargado:
                    return _HiloScreenBody(hilo: state.hilo!);
                  default:
                }

                return Container();
              },
            ),
          ),
          bottomSheet: const ComentarEnHilo(),
        ),
      ),
    );
  }
}

class _HiloScreenBody extends StatelessWidget {
  const _HiloScreenBody({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [_HiloInformacion(hilo: hilo), const _Comentarios()],
    );
  }
}

class _HiloInformacion extends StatelessWidget {
  static final HashMap<BanderasDeHilo, Widget> _banderas = HashMap.from({
    BanderasDeHilo.dados: const Icon(Icons.casino_outlined),
    BanderasDeHilo.encuesta: const Icon(Icons.bar_chart_outlined),
    BanderasDeHilo.sticky: const Icon(CupertinoIcons.pin),
    BanderasDeHilo.idUnico: const Icon(Icons.person_outline)
  });

  const _HiloInformacion({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          color: Color(0xffd8d9dd),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //banderas
                _Banderas(hilo: hilo, banderas: _banderas),
                //subcategoria
                _Subcategoria(hilo: hilo),
                const SizedBox(
                  height: 5,
                ),
                //acciones
                _AccionesEjecutables(hilo: hilo),
                //encuesta
                //portada
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: MultiMediaDisplay(
                    media: hilo.portada.spoileable,
                    dimensionableBuilder: (child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: MediaSpoileable(
                            child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 400, maxWidth: double.infinity),
                                child: child)),
                      );
                    },
                  ),
                ),
                Text(
                  hilo.titulo,
                  style: const TituloStyle(),
                ),
                //descripcion
                Text(
                  hilo.descripcion,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccionesEjecutables extends StatelessWidget {
  const _AccionesEjecutables({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const Icon(Icons.flag_outlined)),
                    ),
                    SizedBox(
                      width: 35,
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const Icon(Icons.flag_outlined)),
                    ),
                    SizedBox(
                      width: 35,
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const Icon(Icons.flag_outlined)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Gatubi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Tag(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                      child: const SizedBox(
                        height: 17,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: FittedBox(
                              child: Text("MOD",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            )),
                      )),
                  const SizedBox(width: 5),
                  Text(HorariosService.diferencia(
                          utcNow: DateTime.now().toUtc(), time: hilo.creadoEn)
                      .toString()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Subcategoria extends StatelessWidget {
  const _Subcategoria({
    super.key,
    required this.hilo,
  });

  final Hilo hilo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                      height: 35,
                      width: 35,
                      child: Image(
                          image: hilo.categoria.imagen.toProvider(),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(width: 10),
                Text(
                  hilo.categoria.nombre,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right))
          ],
        ),
      ),
    );
  }
}

class _Banderas extends StatelessWidget {
  const _Banderas({
    super.key,
    required this.hilo,
    required HashMap<BanderasDeHilo, Widget> banderas,
  }) : _banderas = banderas;

  final Hilo hilo;
  final HashMap<BanderasDeHilo, Widget> _banderas;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          const BackButton(),
          ...hilo.banderas.map((bandera) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: OutlinedIcon(
                    child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: _banderas[bandera]!)),
              ))
        ],
      ),
    );
  }
}

class _Comentarios extends StatefulWidget {
  const _Comentarios();

  @override
  State<_Comentarios> createState() => _ComentariosState();
}

class _ComentariosState extends State<_Comentarios> {
  final HashMap<ComentarioId, GlobalKey> _keys = HashMap();

  static const Widget _cargando = _ComentarioCargando();

  @override
  void initState() {
    context.read<HiloBloc>().add(CargarComentarios());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: const Text(
              "Comentarios (20)",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        BlocListener<HiloBloc, HiloState>(
          listenWhen: (previous, current) =>
              previous.comentarios.length != current.comentarios.length,
          listener: (context, state) {
            for (var c in state.comentarios) {
              if (c is! ComentarioListEntry) return;

              if (_keys[c.id] == null) {
                _keys[c.id] = GlobalKey();
              }
            }
          },
          child: BlocBuilder<HiloBloc, HiloState>(
            buildWhen: (previous, current) =>
                previous.comentarios.length != current.comentarios.length,
            builder: (context, state) {
              final List<ComentarioEntry> comentarios = state.comentarios;
              return SliverList.builder(
                  itemCount: comentarios.length,
                  itemBuilder: (context, index) {
                    ComentarioEntry comentario = comentarios[index];
                    switch (comentario) {
                      case ComentarioListEntry c:
                        return _Comentario(
                            key: _keys[c.id], comentario: comentario);
                      case ComentarioListCargandoEntry _:
                        return _cargando;
                      default:
                        throw Exception("");
                    }
                  });
            },
          ),
        ),
      ],
    );
  }
}

class _Comentario extends StatelessWidget {
  static final BoxDecoration _decoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(15));

  final ComentarioListEntry comentario;

  const _Comentario({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _decoration,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _Color(comentario: comentario),
                    const SizedBox(width: 5),
                    Text(
                      comentario.autor.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    _Tags(comentario: comentario),
                  ],
                ),
                Text(HorariosService.diferencia(
                        utcNow: DateTime.now().toUtc(),
                        time: comentario.creado_en)
                    .toString())
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(comentario.texto)
        ],
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({
    super.key,
    required this.comentario,
  });

  final ComentarioListEntry comentario;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Tag(
          tag: comentario.datos.tag,
        ),
        const SizedBox(width: 5),
        comentario.datos.tagUnico != null
            ? Row(
                children: [_TagUnico(tag: comentario.datos.tagUnico!)],
              )
            : const SizedBox()
      ],
    );
  }
}

class _ComentarioCargando extends StatelessWidget {
  const _ComentarioCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _Tag extends StatelessWidget {
  final String tag;
  const _Tag({
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<TaggueosController>().tagguear(
            tag: tag,
            texto: context.read<ComentarHiloBloc>().state.texto,
          ),
      child: Tag(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: FittedBox(
          child: Text(
            tag,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _TagUnico extends StatelessWidget {
  static final List<Color> _colors = [
    const Color(0xFFdacecd), // dacecd
    const Color(0xFFfddad9), // fddad9
    const Color(0xFFf1d2d5), // f1d2d5
    const Color(0xFFfeebdc), // feebdc
    const Color(0xFFf4f7ef), // f4f7ef
    const Color(0xFFffdcd1), // ffdcd1
    const Color(0xFFbbe7ff), // bbe7ff
    const Color(0xFFccebd9), // ccebd9
    const Color(0xFFf7e8d9), // f7e8d9
    const Color(0xFFffffe5), // ffffe5
  ];

  final String tag;

  const _TagUnico({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Tag(
        color: ColorPicker.pickColor(tag, _colors),
        borderRadius: BorderRadius.circular(5),
        child: FittedBox(
          child: Text(
            tag,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class _Color extends StatelessWidget {
  static final HashMap<ColoresDeComentario, Widget> _colores = HashMap.from({
    ColoresDeComentario.amarillo: const ColoredBox(color: Colors.yellow),
    ColoresDeComentario.multi: const MultiColor(),
    ColoresDeComentario.rojo: const ColoredBox(color: Colors.red)
  });

  final ComentarioListEntry comentario;

  const _Color({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            _colores[comentario.color]!,
            Positioned.fill(
              child: Center(
                child: Text(
                  comentario.datos.dados ?? comentario.autor.rangoCorto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MultiColor extends LinearGradientAnimation {
  static const List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue
  ];

  const MultiColor({super.key}) : super(colors: _colors);
}

class Invertido extends LinearGradientAnimation {
  static const List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue
  ];

  const Invertido({super.key}) : super(colors: _colors, reverse: true);
}

class OutlinedIcon extends StatelessWidget {
  final Widget child;
  const OutlinedIcon({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: const Color.fromRGBO(199, 199, 199, 1), width: 1.25)),
      child: child,
    );
  }
}

class TituloStyle extends TextStyle {
  const TituloStyle() : super(fontSize: 29, fontWeight: FontWeight.w900);
}

class ComentarEnHilo extends StatelessWidget {
  const ComentarEnHilo({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<ComentarHiloBloc, ComentarHiloState>(
              buildWhen: (previous, current) => previous.media != current.media,
              builder: (context, state) {
                if (state.media != null) {
                  return Miniatura(
                    media: state.media!.spoileable,
                  );
                }
                return Container();
              },
            ),
            Row(
              children: [
                ColoredIconButton(
                  onPressed: () => ComentarHiloOpciones.show(context),
                  icon: const Icon(Icons.three_k_rounded),
                ),
                const _ComentarInput(),
                ColoredIconButton(
                    onPressed: () => context
                        .read<ComentarHiloBloc>()
                        .add(EnviarComentario()),
                    icon: const Icon(Icons.send)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ComentarInput extends StatefulWidget {
  const _ComentarInput({super.key});

  @override
  State<_ComentarInput> createState() => __ComentarInputState();
}

class __ComentarInputState extends State<_ComentarInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() => context
        .read<ComentarHiloBloc>()
        .add(CambiarComentario(comentario: _controller.text)));

    context.read<TaggueosController>().addListener(() {
      String? tag = context.read<TaggueosController>().tag;
      _controller.text = '${_controller.text}>>$tag';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: !isKeyboardVisible ? 1 : 4,
          decoration: FlatInputDecoration(
              borderRadius: 15, hintText: "Escribe tu comentario..."),
        ),
      )),
    );
  }
}

class EncuestaDeHilo extends StatelessWidget {
  final Encuesta encuesta;
  const EncuestaDeHilo({super.key, required this.encuesta});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: EncuestaWidget(encuesta: encuesta),
    );
  }
}

class ColorPicker {
  const ColorPicker._();

  static Color pickColor(String text, List<Color> colors) {
    if (text.isEmpty) throw ArgumentError("[text] no puede estar vacia");

    if (colors.isEmpty) throw ArgumentError("[colors] no puede estar vacia");

    int n = 0;

    for (var i = 0; i < text.length; i++) {
      n += text.codeUnitAt(i);
    }

    int index = (n % colors.length);

    return colors[index];
  }
}

class ComentarHiloOpciones extends StatelessWidget {
  const ComentarHiloOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        ...ItemGrupoSliverList.GenerarSlivers([
          GrupoSeleccionable(seleccionables: [
            ItemSeleccionableTileList(
              nombre: "Galeria",
              icon: FontAwesomeIcons.image,
              onTap: () {
                GetGalleryFileUsecase usecase = GetIt.I.get();

                usecase
                    .handle(const GetGalleryFileRequest(extensions: []))
                    .then(
                  (value) {
                    value.fold((l) => null, (r) {
                      if (r != null) {
                        context
                            .read<ComentarHiloBloc>()
                            .add(AgregarMedia(media: r));
                      }
                    });
                  },
                );
              },
            ),
            ItemSeleccionableTileList(
              nombre: "Enlace",
              icon: FontAwesomeIcons.link,
            )
          ])
        ])
      ],
    );
  }

  static void show(BuildContext context) =>
      SliverBottomSheet.show(context, child: const ComentarHiloOpciones());
}
