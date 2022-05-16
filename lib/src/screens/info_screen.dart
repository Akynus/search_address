import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:latlong2/latlong.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:search_address/src/blocs/address/address_bloc.dart';
import 'package:search_address/src/models/address.dart';
import 'package:search_address/src/widgets/info_label.dart';

class InfoScreen extends StatefulWidget {
  final Address data;

  const InfoScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  static const route = "/info";

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late MapController controller;
  late MaskTextInputFormatter formatter;

  @override
  void initState() {
    super.initState();
    controller = MapController();
    formatter = MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'\d')});

    //if (latLng != null) controller.move(latLng!, 13.0);
  }

  LatLng? get latLng {
    if ((widget.data.location.coordinates.longitude != null && widget.data.location.coordinates.latitude != null)) {
      return LatLng(
        double.parse(widget.data.location.coordinates.latitude!),
        double.parse(widget.data.location.coordinates.longitude!),
      );
    }
    return null;
  }

  List<Marker> get buildMarkers {
    List<Marker> list = [];

    if (latLng != null) {
      var marker = Marker(
        point: latLng!,
        builder: (_) => const Icon(
          Icons.location_pin,
          color: Colors.red,
        ),
      );
      list.add(marker);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text(translate("screen.info.app_bar.title", args: {"text": formatter.maskText(widget.data.cep)})),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                child: Column(
                  children: [
                    InfoLabel(
                      label: "Rua",
                      text: widget.data.street,
                    ),
                    InfoLabel(
                      label: "Bairro",
                      text: widget.data.neighborhood,
                    ),
                    InfoLabel(
                      label: "Cidade",
                      text: widget.data.city,
                    ),
                    InfoLabel(
                      label: "Estado",
                      text: widget.data.state,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Card(
                  child: FlutterMap(
                    mapController: controller,
                    options: MapOptions(
                      zoom: 18.0,
                      center: latLng,
                      controller: controller,
                      maxZoom: 18.0,
                    ),
                    layers: [
                      TileLayerOptions(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
                      MarkerLayerOptions(
                        markers: buildMarkers,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
