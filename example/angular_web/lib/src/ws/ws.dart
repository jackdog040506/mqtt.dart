import 'dart:io';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:mqtt/mqtt_connection_html_websocket.dart';
import 'package:mqtt/mqtt_shared.dart';

@Component(
    selector: 'wss',
    templateUrl: 'ws.html',
    directives: const [
      CORE_DIRECTIVES, formDirectives
    ]
)
class Ws implements OnInit {
  String inp = "";
  String message = "";
  MqttClient c;

  @override
  ngOnInit() {
    var mqttCnx = new MqttConnectionHtmlWebSocket.setOptions(
        "ws://127.0.0.1:61614/mqtt");
    c = new MqttClient(mqttCnx, clientID: "MyClientID",
        qos: QOS_1,
        userName: "admin",
        password: "admin");
    c.connect(onConnectionLost).then((c) => onConnected).catchError((e) =>
        print("Error: $e"), test: (e) => e is SocketException)
        .catchError((mqttErr) => print("Error: $mqttErr")).then((_) =>
        c.subscribe("World", QOS_1, onMessage)
            .then((s) =>
            print("Subscription done - ID: ${s.messageID} - Qos: ${s
                .grantedQoS}"))).then((_) =>
        c.publish("World", "MyClientID join chat"));
  }

  void onMessage(topic, data) {
    print("[$topic] $data");
    print("onMessageArrived $message");
    message = "$message\n$data";
  }

  void onConnectionLost() {
    print("onConnectionLost");
  }

  void onConnected(c) {
    print("onSuccess");
  }

  void sendMsg() {
    c.publish("World", inp)
        .then((m) => print("Message ${m.messageID} published"));
    inp="";
  }
}