import 'dart:convert';

const _mapStyle = [
  {
    "featureType": "all",
    "elementType": "all",
    "stylers": [
      {"saturation": -100},
      {"gamma": 0.5}
    ]
  },
  {
    "featureType": "all",
    "elementType": "labels.text",
    "stylers": [
      {"color": "#828591"}
    ]
  },
  {
    "featureType": "all",
    "elementType": "labels.text.stroke",
    "stylers": [
      {"visibility": "off"}
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.fill",
    "stylers": [
      {"color": "#bdbdbd"}
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {"visibility": "on"},
      {"color": "#a7a7a7"}
    ]
  }
];

final mapStyle = jsonEncode(_mapStyle);
