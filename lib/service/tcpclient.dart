import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/Provider/tcpprovider/tcp_provider_receive_data.dart';



final tcpProvider = Provider.autoDispose((ref) => TCPManager(ref));

String serverIp = ""; // Server IP

class TCPManager {
  Ref ref;

  TCPManager(this.ref);

  int port = 5000; // Server Port
  Socket? clientSocket;
  bool isConnect = false; // Server Connect bool
  bool responseNotReached = true;

  bool dataReceived = false;

  Future<bool> connectToServer() async {
    return Future.delayed(
        const Duration(milliseconds: 500),
            () => Socket.connect(serverIp, port,
            timeout: const Duration(seconds: 10))).then((socket) {
      clientSocket = socket;
      print(
          "Connected to ${socket.remoteAddress.address}:${socket.remotePort}");
      isConnect = true;
      _responsePacket();
      return true;
    }).catchError((e) {
      print(e.toString());

      ref.read(tcpReceiveDataNotifier.notifier).getResponseData('TimeOut');

      Future.delayed(const Duration(milliseconds: 200),
              () => ref.read(tcpReceiveDataNotifier.notifier).getResponseData(''));

      isConnect = true;
      return connectToServer();
    });
  }

  _responsePacket() async {
    clientSocket?.listen((onData) {
      if (!dataReceived) {
        print("Response <--: ${String.fromCharCodes(onData).trim()}");
        String response = String.fromCharCodes(onData).trim();
        dataReceived = true;
        responseNotReached = true;
        ref.read(tcpReceiveDataNotifier.notifier).getResponseData(response);
      }
    }, onDone: onDone, onError: onError);


  }

  void connect() async {}

  Future<bool> sendPackets(String message) async {
    responseNotReached = false;
    try {
      if (isConnect) {
        Future.delayed(const Duration(milliseconds: 200),
                () => clientSocket?.write("$message\n"));
        dataReceived = false;
        print("Request --> $message");
        ref.read(tcpReceiveDataNotifier.notifier).getResponseData('');
        Future.delayed(const Duration(seconds: 100), () {
          if (!responseNotReached) {
            ref
                .read(tcpReceiveDataNotifier.notifier)
                .getResponseData('TimeOut');
            ref.read(tcpReceiveDataNotifier.notifier).getResponseData('');
          }
        });

        return true;
      }
      else {
        if (await connectToServer()) {
          Future.delayed(const Duration(milliseconds: 100),
                  () => clientSocket?.write("$message\n"));
          dataReceived = false;
          print("Request--> $message");
          ref.read(tcpReceiveDataNotifier.notifier).getResponseData('');
          Future.delayed(const Duration(seconds: 10000), () {
            if (!responseNotReached) {
              ref
                  .read(tcpReceiveDataNotifier.notifier)
                  .getResponseData('TimeOut');

              ref.read(tcpReceiveDataNotifier.notifier).getResponseData('');
            }
          });
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  void onDone() {
    disconnectFromServer();
  }

  void onError(e) {
    print("onError: $e");
    disconnectFromServer();
  }

  void disconnectFromServer() {
    print("disconnectFromServer");
    isConnect = false;
    clientSocket?.close();
    clientSocket = null;
  }
}
