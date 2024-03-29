import 'dart:io';
import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:drawtask/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../blocs/blocs.dart';
import '../config/config.dart';

class PictureSocket {
  final _socketClient = SocketConnect.instance.socket!;
  Socket get socketConnect => _socketClient;

  // EMITTER --------------------------

  void addPicture(BuildContext context, Uint8List bytes, String gameId) async {
    try {
      final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.png').writeAsBytes(bytes);

      //final compressFile = await compressAndGetFile(file, file.path);

      final cloudinary = CloudinaryPublic('dwdhehnzb', 'sxkgnieo');
      CloudinaryResponse imageRes = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(file.path, folder: gameId));
      file.delete();

      // EMIT PICTURE TO DATABASE
      _socketClient.emit("addPicture", {
        "gameId": gameId,
        "imageUrl": imageRes.secureUrl,
        "userOwnerId": authBloc.state.user.id,
      });

      // LISTENER TO SUCCESS
      _socketClient.on("addPictureSuccess", (_) async {
        context.goNamed(RouteConstants.dashboard);
        context.read<DrawBloc>().add(ClearEvent());
        
        _socketClient.off('addPictureSuccess');
      });
    } catch (e) {
      if(context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  // compress image before added to db

  // Future<XFile?> compressAndGetFile(File file, String targetPath) async {
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //       file.absolute.path, targetPath,
  //       quality: 88,
  //     );

  //   return result;
  // }
}
