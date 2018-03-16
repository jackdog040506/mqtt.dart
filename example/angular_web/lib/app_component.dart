import 'package:angular/angular.dart';

import 'package:untitled/src/ws/ws.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: const [Ws],
)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
