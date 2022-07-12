import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gasjm/app/modules/ubicacion/ubicacion_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;
  final _controller = UbicacionController();

//Por defecto en false los estado del Gps
  GpsBloc()
      : super(const GpsState(
            isGpsEnabled: false, isGpsPermissionGranted: false)) {

    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));

    _init();
  }


  Future<void> _init() async {
    print('\n#######################################\n');
    
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);
    /*final isEnabled = await _checkGpsStatus();
    print('isEnabled: $isEnabled');
*/
    add(GpsAndPermissionEvent(
        isGpsEnabled: gpsInitStatus[0],
        isGpsPermissionGranted: gpsInitStatus[1]));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    //Revisar si el servicio esta habilitado?
    final isEnable = await Geolocator.isLocationServiceEnabled();


//cambio de estados, disparar eventos
    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
       
    print('I_____________________$event\n');

      final isEnabled = (event.index == 1) ? true : false;
      print('>\n service status $isEnabled');
      add(GpsAndPermissionEvent(
          isGpsEnabled: isEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted));
    });

    return isEnable;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.denied:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.granted:

      case PermissionStatus.restricted:

      case PermissionStatus.limited:

      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        // ignore: avoid_print
        print('*******object******\n');
        final estado = openAppSettings();

        estado.then((value) {
          if (value) {
            _controller.cargarIdentificacion();
          }
        });
      // final s= estado.then((s) => s);
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription!.cancel();
    //todo: Limpiar el ServiceStatus Stream
    return super.close();
  }
}
