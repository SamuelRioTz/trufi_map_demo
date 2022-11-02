import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';
// ignore: uri_does_not_exist
// import 'api_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vector_map_tiles Example',
      theme: ThemeData.light(),
      home: const MyHomePage(title: 'vector_map_tiles Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MapController _controller = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: Column(children: [
          Flexible(
              child: FlutterMap(
            mapController: _controller,
            options: MapOptions(
                center: LatLng(49.246292, -123.116226),
                zoom: 10,
                maxZoom: 22,
                interactiveFlags: InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.doubleTapZoom),
            children: [
              // normally you would see TileLayer which provides raster tiles
              // instead this vector tile layer replaces the standard tile layer
              VectorTileLayer(
                theme: _mapTheme(),
                backgroundTheme: _backgroundTheme(),
                // tileOffset: TileOffset.mapbox, enable with mapbox
                tileProviders: TileProviders(
                    // Name must match name under "sources" in theme
                    {'openmaptiles': _cachingTileProvider(_urlTemplate())}),
              )
            ],
          )),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_statusText()])
        ])));
  }

  VectorTileProvider _cachingTileProvider(String urlTemplate) {
    return MemoryCacheVectorTileProvider(
        delegate: NetworkVectorTileProvider(
            urlTemplate: urlTemplate,
            // this is the maximum zoom of the provider, not the
            // maximum of the map. vector tiles are rendered
            // to larger sizes to support higher zoom levels
            maximumZoom: 14),
        maxSizeBytes: 1024 * 1024 * 2);
  }

  Theme _mapTheme() {
    const data={
  "version": 8,
  "name": "Trufi Liberty",
  "metadata": {
    "maputnik:license": "https://github.com/maputnik/osm-liberty/blob/gh-pages/LICENSE.md",
    "maputnik:renderer": "mbgljs",
    "openmaptiles:version": "3.x"
  },
  "sources": {
    "openmaptiles": {
      "type": "vector",
      "url": ""
    }
  },
  "sprite": "https://maputnik.github.io/osm-liberty/sprites/osm-liberty",
  "glyphs":"http://fonts.openmaptiles.org/{fontstack}/{range}.pbf",
  "layers": [
    {
      "id": "background",
      "type": "background",
      "paint": {"background-color": "rgb(239,239,239)"}
    },
    {
      "id": "park",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "park",
      "paint": {
        "fill-color": "#d8e8c8",
        "fill-opacity": 0.7,
        "fill-outline-color": "rgba(95, 208, 100, 1)"
      }
    },
    {
      "id": "park_outline",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "park",
      "paint": {
        "line-dasharray": [1, 1.5],
        "line-color": "rgba(228, 241, 215, 1)"
      }
    },
    {
      "id": "landuse_residential",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "landuse",
      "maxzoom": 8,
      "filter": ["==", "class", "residential"],
      "paint": {
        "fill-color": {
          "base": 1,
          "stops": [
            [9, "hsla(0, 3%, 85%, 0.84)"],
            [12, "hsla(35, 57%, 88%, 0.49)"]
          ]
        }
      }
    },
    {
      "id": "landcover_wood",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "landcover",
      "filter": ["all", ["==", "class", "wood"]],
      "paint": {
        "fill-antialias": false,
        "fill-color": "hsla(98, 61%, 72%, 0.7)",
        "fill-opacity": 0.4
      }
    },
    {
      "id": "landcover_grass",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "landcover",
      "filter": ["all", ["==", "class", "grass"]],
      "paint": {
        "fill-antialias": false,
        "fill-color": "rgba(176, 213, 154, 1)",
        "fill-opacity": 0.3
      }
    },
    {
      "id": "landcover_ice",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "landcover",
      "filter": ["all", ["==", "class", "ice"]],
      "paint": {
        "fill-antialias": false,
        "fill-color": "rgba(224, 236, 236, 1)",
        "fill-opacity": 0.8
      }
    },
    {
      "id": "landuse_cemetery",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "landuse",
      "filter": ["==", "class", "cemetery"],
      "paint": {"fill-color": "hsl(75, 37%, 81%)"}
    },
    {
      "id": "landuse_hospital",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "landuse",
      "filter": ["==", "class", "hospital"],
      "paint": {"fill-color": "#fde"}
    },
    {
      "id": "landuse_school",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "landuse",
      "filter": ["==", "class", "school"],
      "paint": {"fill-color": "rgb(236,238,204)"}
    },
    {
      "id": "waterway_tunnel",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "waterway",
      "filter": ["all", ["==", "brunnel", "tunnel"]],
      "paint": {
        "line-color": "#a0c8f0",
        "line-dasharray": [3, 3],
        "line-gap-width": {"stops": [[12, 0], [20, 6]]},
        "line-opacity": 1,
        "line-width": {"base": 1.4, "stops": [[8, 1], [20, 2]]}
      }
    },
    {
      "id": "waterway_river",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "waterway",
      "filter": ["all", ["==", "class", "river"], ["!=", "brunnel", "tunnel"]],
      "layout": {"line-cap": "round"},
      "paint": {
        "line-color": "#a0c8f0",
        "line-width": {"base": 1.2, "stops": [[11, 0.5], [20, 6]]}
      }
    },
    {
      "id": "waterway_other",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "waterway",
      "filter": ["all", ["!=", "class", "river"], ["!=", "brunnel", "tunnel"]],
      "layout": {"line-cap": "round"},
      "paint": {
        "line-color": "#a0c8f0",
        "line-width": {"base": 1.3, "stops": [[13, 0.5], [20, 6]]}
      }
    },
    {
      "id": "water",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "water",
      "filter": ["all", ["!=", "brunnel", "tunnel"]],
      "paint": {"fill-color": "rgb(158,189,255)"}
    },
    {
      "id": "landcover_sand",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "landcover",
      "filter": ["all", ["==", "class", "sand"]],
      "paint": {"fill-color": "rgba(247, 239, 195, 1)"}
    },
    {
      "id": "aeroway_fill",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "aeroway",
      "minzoom": 11,
      "filter": ["==", "\$type", "Polygon"],
      "paint": {"fill-color": "rgba(229, 228, 224, 1)", "fill-opacity": 0.7}
    },
    {
      "id": "aeroway_runway",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "aeroway",
      "minzoom": 11,
      "filter": [
        "all",
        ["==", "\$type", "LineString"],
        ["==", "class", "runway"]
      ],
      "paint": {
        "line-color": "#f0ede9",
        "line-width": {"base": 1.2, "stops": [[11, 3], [20, 16]]}
      }
    },
    {
      "id": "aeroway_taxiway",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "aeroway",
      "minzoom": 11,
      "filter": [
        "all",
        ["==", "\$type", "LineString"],
        ["==", "class", "taxiway"]
      ],
      "paint": {
        "line-color": "#f0ede9",
        "line-width": {"base": 1.2, "stops": [[11, 0.5], [20, 6]]}
      }
    },
    {
      "id": "tunnel_motorway_link_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "motorway"],
        ["==", "ramp", 1],
        ["==", "brunnel", "tunnel"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-dasharray": [0.5, 0.25],
        "line-width": {
          "base": 1.2,
          "stops": [[12, 1], [13, 3], [14, 4], [20, 15]]
        }
      }
    },
    {
      "id": "tunnel_service_track_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["in", "class", "service", "track"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#cfcdca",
        "line-dasharray": [0.5, 0.25],
        "line-width": {"base": 1.2, "stops": [[15, 1], [16, 4], [20, 11]]}
      }
    },
    {
      "id": "tunnel_link_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "ramp", 1], ["==", "brunnel", "tunnel"]],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[12, 1], [13, 3], [14, 4], [20, 15]]
        }
      }
    },
    {
      "id": "tunnel_street_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["in", "class", "street", "street_limited"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#cfcdca",
        "line-opacity": {"stops": [[12, 0], [12.5, 1]]},
        "line-width": {
          "base": 1.2,
          "stops": [[12, 0.5], [13, 1], [14, 4], [20, 15]]
        }
      }
    },
    {
      "id": "tunnel_secondary_tertiary_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["in", "class", "secondary", "tertiary"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {"base": 1.2, "stops": [[8, 1.5], [20, 17]]}
      }
    },
    {
      "id": "tunnel_trunk_primary_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["in", "class", "primary", "trunk"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[5, 0.4], [6, 0.7], [7, 1.75], [20, 22]]
        }
      }
    },
    {
      "id": "tunnel_motorway_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "motorway"],
        ["!=", "ramp", 1],
        ["==", "brunnel", "tunnel"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-dasharray": [0.5, 0.25],
        "line-width": {
          "base": 1.2,
          "stops": [[5, 0.4], [6, 0.7], [7, 1.75], [20, 22]]
        }
      }
    },
    {
      "id": "tunnel_path_pedestrian",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "\$type", "LineString"],
        ["==", "brunnel", "tunnel"],
        ["in", "class", "path", "pedestrian"]
      ],
      "paint": {
        "line-color": "hsl(0, 0%, 100%)",
        "line-dasharray": [1, 0.75],
        "line-width": {"base": 1.2, "stops": [[14, 0.5], [20, 10]]}
      }
    },
    {
      "id": "tunnel_motorway_link",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "motorway"],
        ["==", "ramp", 1],
        ["==", "brunnel", "tunnel"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fc8",
        "line-width": {
          "base": 1.2,
          "stops": [[12.5, 0], [13, 1.5], [14, 2.5], [20, 11.5]]
        }
      }
    },
    {
      "id": "tunnel_service_track",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["in", "class", "service", "track"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fff",
        "line-width": {"base": 1.2, "stops": [[15.5, 0], [16, 2], [20, 7.5]]}
      }
    },
    {
      "id": "tunnel_link",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "ramp", 1], ["==", "brunnel", "tunnel"]],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fff4c6",
        "line-width": {
          "base": 1.2,
          "stops": [[12.5, 0], [13, 1.5], [14, 2.5], [20, 11.5]]
        }
      }
    },
    {
      "id": "tunnel_minor",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "brunnel", "tunnel"], ["in", "class", "minor"]],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fff",
        "line-width": {"base": 1.2, "stops": [[13.5, 0], [14, 2.5], [20, 11.5]]}
      }
    },
    {
      "id": "tunnel_secondary_tertiary",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["in", "class", "secondary", "tertiary"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fff4c6",
        "line-width": {"base": 1.2, "stops": [[6.5, 0], [7, 0.5], [20, 10]]}
      }
    },
    {
      "id": "tunnel_trunk_primary",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["in", "class", "primary", "trunk"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fff4c6",
        "line-width": {"base": 1.2, "stops": [[5, 0], [7, 1], [20, 18]]}
      }
    },
    {
      "id": "tunnel_motorway",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "motorway"],
        ["!=", "ramp", 1],
        ["==", "brunnel", "tunnel"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#ffdaa6",
        "line-width": {"base": 1.2, "stops": [[5, 0], [7, 1], [20, 18]]}
      }
    },
    {
      "id": "tunnel_major_rail",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "brunnel", "tunnel"], ["in", "class", "rail"]],
      "paint": {
        "line-color": "#bbb",
        "line-width": {"base": 1.4, "stops": [[14, 0.4], [15, 0.75], [20, 2]]}
      }
    },
    {
      "id": "tunnel_major_rail_hatching",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "brunnel", "tunnel"], ["==", "class", "rail"]],
      "paint": {
        "line-color": "#bbb",
        "line-dasharray": [0.2, 8],
        "line-width": {"base": 1.4, "stops": [[14.5, 0], [15, 3], [20, 8]]}
      }
    },
    {
      "id": "tunnel_transit_rail",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["in", "class", "transit"]
      ],
      "paint": {
        "line-color": "#bbb",
        "line-width": {"base": 1.4, "stops": [[14, 0.4], [15, 0.75], [20, 2]]}
      }
    },
    {
      "id": "tunnel_transit_rail_hatching",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "tunnel"],
        ["==", "class", "transit"]
      ],
      "paint": {
        "line-color": "#bbb",
        "line-dasharray": [0.2, 8],
        "line-width": {"base": 1.4, "stops": [[14.5, 0], [15, 3], [20, 8]]}
      }
    },
    {
      "id": "road_area_pattern",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "\$type", "Polygon"]],
      "paint": {"fill-pattern": "pedestrian_polygon"}
    },
    {
      "id": "road_motorway_link_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 12,
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "class", "motorway"],
        ["==", "ramp", 1]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[12, 1], [13, 3], [14, 4], [20, 15]]
        }
      }
    },
    {
      "id": "road_service_track_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "service", "track"]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#cfcdca",
        "line-width": {"base": 1.2, "stops": [[15, 1], [16, 4], [20, 11]]}
      }
    },
    {
      "id": "road_link_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 13,
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["!in", "class", "pedestrian", "path", "track", "service", "motorway"],
        ["==", "ramp", 1]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[12, 1], [13, 3], [14, 4], [20, 15]]
        }
      }
    },
    {
      "id": "road_minor_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "\$type", "LineString"],
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "minor"],
        ["!=", "ramp", 1]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#cfcdca",
        "line-opacity": {"stops": [[12, 0], [12.5, 1]]},
        "line-width": {
          "base": 1.2,
          "stops": [[12, 0.5], [13, 1], [14, 4], [20, 20]]
        }
      }
    },
    {
      "id": "road_secondary_tertiary_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "secondary", "tertiary"],
        ["!=", "ramp", 1]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {"base": 1.2, "stops": [[8, 1.5], [20, 17]]}
      }
    },
    {
      "id": "road_trunk_primary_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "primary", "trunk"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[5, 0.4], [6, 0.7], [7, 1.75], [20, 22]]
        }
      }
    },
    {
      "id": "road_motorway_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 5,
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "class", "motorway"],
        ["!=", "ramp", 1]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[5, 0.4], [6, 0.7], [7, 1.75], [20, 22]]
        }
      }
    },
    {
      "id": "road_path_pedestrian",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 14,
      "filter": [
        "all",
        ["==", "\$type", "LineString"],
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "path", "pedestrian"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "hsl(0, 0%, 100%)",
        "line-dasharray": [1, 0.7],
        "line-width": {"base": 1.2, "stops": [[14, 1], [20, 10]]}
      }
    },
    {
      "id": "road_motorway_link",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 12,
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "class", "motorway"],
        ["==", "ramp", 1]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#fc8",
        "line-width": {
          "base": 1.2,
          "stops": [[12.5, 0], [13, 1.5], [14, 2.5], [20, 11.5]]
        }
      }
    },
    {
      "id": "road_service_track",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "service", "track"]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#fff",
        "line-width": {"base": 1.2, "stops": [[15.5, 0], [16, 2], [20, 7.5]]}
      }
    },
    {
      "id": "road_link",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 13,
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "ramp", 1],
        ["!in", "class", "pedestrian", "path", "track", "service", "motorway"]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#fea",
        "line-width": {
          "base": 1.2,
          "stops": [[12.5, 0], [13, 1.5], [14, 2.5], [20, 11.5]]
        }
      }
    },
    {
      "id": "road_minor",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "\$type", "LineString"],
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "minor"]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "#fff",
        "line-width": {"base": 1.2, "stops": [[13.5, 0], [14, 2.5], [20, 18]]}
      }
    },
    {
      "id": "road_secondary_tertiary",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "secondary", "tertiary"]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "rgba(255, 193, 110, 1)",
        "line-width": {"base": 1.2, "stops": [[6.5, 0], [8, 0.5], [20, 13]]}
      }
    },
    {
      "id": "road_trunk_primary",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["in", "class", "primary", "trunk"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fea",
        "line-width": {"base": 1.2, "stops": [[5, 0], [7, 1], [20, 18]]}
      }
    },
    {
      "id": "road_motorway",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 5,
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "class", "motorway"],
        ["!=", "ramp", 1]
      ],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": {
          "base": 1,
          "stops": [[5, "hsl(26, 87%, 62%)"], [6, "#fc8"]]
        },
        "line-width": {"base": 1.2, "stops": [[5, 0], [7, 1], [20, 18]]}
      }
    },
    {
      "id": "road_major_rail",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "class", "rail"]
      ],
      "paint": {
        "line-color": "#bbb",
        "line-width": {"base": 1.4, "stops": [[14, 0.4], [15, 0.75], [20, 2]]}
      }
    },
    {
      "id": "road_major_rail_hatching",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "class", "rail"]
      ],
      "paint": {
        "line-color": "#bbb",
        "line-dasharray": [0.2, 8],
        "line-width": {"base": 1.4, "stops": [[14.5, 0], [15, 3], [20, 8]]}
      }
    },
    {
      "id": "road_transit_rail",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "class", "transit"]
      ],
      "paint": {
        "line-color": "#bbb",
        "line-width": {"base": 1.4, "stops": [[14, 0.4], [15, 0.75], [20, 2]]}
      }
    },
    {
      "id": "road_transit_rail_hatching",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["!in", "brunnel", "bridge", "tunnel"],
        ["==", "class", "transit"]
      ],
      "paint": {
        "line-color": "#bbb",
        "line-dasharray": [0.2, 8],
        "line-width": {"base": 1.4, "stops": [[14.5, 0], [15, 3], [20, 8]]}
      }
    },
    {
      "id": "road_one_way_arrow",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 15,
      "filter": ["==", "oneway", 1],
      "layout": {"icon-image": "arrow", "symbol-placement": "line"}
    },
    {
      "id": "road_one_way_arrow_opposite",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "minzoom": 15,
      "filter": ["==", "oneway", -1],
      "layout": {
        "icon-image": "arrow",
        "symbol-placement": "line",
        "icon-rotate": 180
      }
    },
    {
      "id": "bridge_motorway_link_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "motorway"],
        ["==", "ramp", 1],
        ["==", "brunnel", "bridge"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[12, 1], [13, 3], [14, 4], [20, 15]]
        }
      }
    },
    {
      "id": "bridge_service_track_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "bridge"],
        ["in", "class", "service", "track"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#cfcdca",
        "line-width": {"base": 1.2, "stops": [[15, 1], [16, 4], [20, 11]]}
      }
    },
    {
      "id": "bridge_link_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "class", "link"], ["==", "brunnel", "bridge"]],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[12, 1], [13, 3], [14, 4], [20, 15]]
        }
      }
    },
    {
      "id": "bridge_street_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "bridge"],
        ["in", "class", "street", "street_limited"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "hsl(36, 6%, 74%)",
        "line-opacity": {"stops": [[12, 0], [12.5, 1]]},
        "line-width": {
          "base": 1.2,
          "stops": [[12, 0.5], [13, 1], [14, 4], [20, 25]]
        }
      }
    },
    {
      "id": "bridge_path_pedestrian_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "\$type", "LineString"],
        ["==", "brunnel", "bridge"],
        ["in", "class", "path", "pedestrian"]
      ],
      "paint": {
        "line-color": "hsl(35, 6%, 80%)",
        "line-dasharray": [1, 0],
        "line-width": {"base": 1.2, "stops": [[14, 1.5], [20, 18]]}
      }
    },
    {
      "id": "bridge_secondary_tertiary_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "bridge"],
        ["in", "class", "secondary", "tertiary"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {"base": 1.2, "stops": [[8, 1.5], [20, 17]]}
      }
    },
    {
      "id": "bridge_trunk_primary_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "bridge"],
        ["in", "class", "primary", "trunk"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[5, 0.4], [6, 0.7], [7, 1.75], [20, 22]]
        }
      }
    },
    {
      "id": "bridge_motorway_casing",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "motorway"],
        ["!=", "ramp", 1],
        ["==", "brunnel", "bridge"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#e9ac77",
        "line-width": {
          "base": 1.2,
          "stops": [[5, 0.4], [6, 0.7], [7, 1.75], [20, 22]]
        }
      }
    },
    {
      "id": "bridge_path_pedestrian",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "\$type", "LineString"],
        ["==", "brunnel", "bridge"],
        ["in", "class", "path", "pedestrian"]
      ],
      "paint": {
        "line-color": "hsl(0, 0%, 100%)",
        "line-dasharray": [1, 0.3],
        "line-width": {"base": 1.2, "stops": [[14, 0.5], [20, 10]]}
      }
    },
    {
      "id": "bridge_motorway_link",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "motorway"],
        ["==", "ramp", 1],
        ["==", "brunnel", "bridge"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fc8",
        "line-width": {
          "base": 1.2,
          "stops": [[12.5, 0], [13, 1.5], [14, 2.5], [20, 11.5]]
        }
      }
    },
    {
      "id": "bridge_service_track",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "bridge"],
        ["in", "class", "service", "track"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fff",
        "line-width": {"base": 1.2, "stops": [[15.5, 0], [16, 2], [20, 7.5]]}
      }
    },
    {
      "id": "bridge_link",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "class", "link"], ["==", "brunnel", "bridge"]],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fea",
        "line-width": {
          "base": 1.2,
          "stops": [[12.5, 0], [13, 1.5], [14, 2.5], [20, 11.5]]
        }
      }
    },
    {
      "id": "bridge_street",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "brunnel", "bridge"], ["in", "class", "minor"]],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fff",
        "line-width": {"base": 1.2, "stops": [[13.5, 0], [14, 2.5], [20, 18]]}
      }
    },
    {
      "id": "bridge_secondary_tertiary",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "bridge"],
        ["in", "class", "secondary", "tertiary"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fea",
        "line-width": {"base": 1.2, "stops": [[6.5, 0], [7, 0.5], [20, 10]]}
      }
    },
    {
      "id": "bridge_trunk_primary",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "brunnel", "bridge"],
        ["in", "class", "primary", "trunk"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fea",
        "line-width": {"base": 1.2, "stops": [[5, 0], [7, 1], [20, 18]]}
      }
    },
    {
      "id": "bridge_motorway",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "motorway"],
        ["!=", "ramp", 1],
        ["==", "brunnel", "bridge"]
      ],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#fc8",
        "line-width": {"base": 1.2, "stops": [[5, 0], [7, 1], [20, 18]]}
      }
    },
    {
      "id": "bridge_major_rail",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "class", "rail"], ["==", "brunnel", "bridge"]],
      "paint": {
        "line-color": "#bbb",
        "line-width": {"base": 1.4, "stops": [[14, 0.4], [15, 0.75], [20, 2]]}
      }
    },
    {
      "id": "bridge_major_rail_hatching",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": ["all", ["==", "class", "rail"], ["==", "brunnel", "bridge"]],
      "paint": {
        "line-color": "#bbb",
        "line-dasharray": [0.2, 8],
        "line-width": {"base": 1.4, "stops": [[14.5, 0], [15, 3], [20, 8]]}
      }
    },
    {
      "id": "bridge_transit_rail",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "transit"],
        ["==", "brunnel", "bridge"]
      ],
      "paint": {
        "line-color": "#bbb",
        "line-width": {"base": 1.4, "stops": [[14, 0.4], [15, 0.75], [20, 2]]}
      }
    },
    {
      "id": "bridge_transit_rail_hatching",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "transportation",
      "filter": [
        "all",
        ["==", "class", "transit"],
        ["==", "brunnel", "bridge"]
      ],
      "paint": {
        "line-color": "#bbb",
        "line-dasharray": [0.2, 8],
        "line-width": {"base": 1.4, "stops": [[14.5, 0], [15, 3], [20, 8]]}
      }
    },
    {
      "id": "building",
      "type": "fill",
      "source": "openmaptiles",
      "source-layer": "building",
      "minzoom": 13,
      "maxzoom": 14,
      "paint": {
        "fill-color": "hsl(35, 8%, 85%)",
        "fill-outline-color": {
          "base": 1,
          "stops": [[13, "hsla(35, 6%, 79%, 0.32)"], [14, "hsl(35, 6%, 79%)"]]
        }
      }
    },
    {
      "id": "building-3d",
      "type": "fill-extrusion",
      "source": "openmaptiles",
      "source-layer": "building",
      "minzoom": 14,
      "paint": {
        "fill-extrusion-color": "hsl(35, 8%, 85%)",
        "fill-extrusion-height": {
          "property": "render_height",
          "type": "identity"
        },
        "fill-extrusion-base": {
          "property": "render_min_height",
          "type": "identity"
        },
        "fill-extrusion-opacity": 0.8
      }
    },
    {
      "id": "boundary_3",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "boundary",
      "minzoom": 8,
      "filter": ["all", ["in", "admin_level", 3, 4]],
      "layout": {"line-join": "round"},
      "paint": {
        "line-color": "#9e9cab",
        "line-dasharray": [5, 1],
        "line-width": {"base": 1, "stops": [[4, 0.4], [5, 1], [12, 1.8]]}
      }
    },
    {
      "id": "boundary_2_z0-4",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "boundary",
      "maxzoom": 5,
      "filter": ["all", ["==", "admin_level", 2], ["!has", "claimed_by"]],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "hsl(248, 1%, 41%)",
        "line-opacity": {"base": 1, "stops": [[0, 0.4], [4, 1]]},
        "line-width": {"base": 1, "stops": [[3, 1], [5, 1.2], [12, 3]]}
      }
    },
    {
      "id": "boundary_2_z5-",
      "type": "line",
      "source": "openmaptiles",
      "source-layer": "boundary",
      "minzoom": 5,
      "filter": ["all", ["==", "admin_level", 2]],
      "layout": {"line-cap": "round", "line-join": "round"},
      "paint": {
        "line-color": "hsl(248, 1%, 41%)",
        "line-opacity": {"base": 1, "stops": [[0, 0.4], [4, 1]]},
        "line-width": {"base": 1, "stops": [[3, 1], [5, 1.2], [12, 3]]}
      }
    },
    {
      "id": "water_name_line",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "waterway",
      "filter": ["all", ["==", "\$type", "LineString"]],
      "layout": {
        "text-field": "{name}",
        "text-font": ["Open Sans Regular"],
        "text-max-width": 5,
        "text-size": 12,
        "symbol-placement": "line"
      },
      "paint": {
        "text-color": "#5d60be",
        "text-halo-color": "rgba(255,255,255,0.7)",
        "text-halo-width": 1
      }
    },
    {
      "id": "water_name_point",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "water_name",
      "filter": ["==", "\$type", "Point"],
      "layout": {
        "text-field": "{name}",
        "text-font": ["Open Sans Regular"],
        "text-max-width": 5,
        "text-size": 12
      },
      "paint": {
        "text-color": "#5d60be",
        "text-halo-color": "rgba(255,255,255,0.7)",
        "text-halo-width": 1
      }
    },
    {
      "id": "poi_z16",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "poi",
      "minzoom": 16,
      "filter": ["all", ["==", "\$type", "Point"], [">=", "rank", 20]],
      "layout": {
        "icon-image": "{class}_11",
        "text-anchor": "top",
        "text-field": "{name}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-max-width": 9,
        "text-offset": [0, 0.6],
        "text-size": 12
      },
      "paint": {
        "text-color": "#666",
        "text-halo-blur": 0.5,
        "text-halo-color": "#ffffff",
        "text-halo-width": 1
      }
    },
    {
      "id": "poi_z15",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "poi",
      "minzoom": 15,
      "filter": [
        "all",
        ["==", "\$type", "Point"],
        [">=", "rank", 7],
        ["<", "rank", 20]
      ],
      "layout": {
        "icon-image": "{class}_11",
        "text-anchor": "top",
        "text-field": "{name}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-max-width": 9,
        "text-offset": [0, 0.6],
        "text-size": 12
      },
      "paint": {
        "text-color": "#666",
        "text-halo-blur": 0.5,
        "text-halo-color": "#ffffff",
        "text-halo-width": 1
      }
    },
    {
      "id": "poi_z14",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "poi",
      "minzoom": 14,
      "filter": [
        "all",
        ["==", "\$type", "Point"],
        [">=", "rank", 1],
        ["<", "rank", 7]
      ],
      "layout": {
        "icon-image": "{class}_11",
        "text-anchor": "top",
        "text-field": "{name}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-max-width": 9,
        "text-offset": [0, 0.6],
        "text-size": 12
      },
      "paint": {
        "text-color": "#666",
        "text-halo-blur": 0.5,
        "text-halo-color": "#ffffff",
        "text-halo-width": 1
      }
    },
    {
      "id": "poi_transit",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "poi",
      "filter": ["all", ["in", "class", "bus", "rail", "airport"]],
      "layout": {
        "icon-image": "{class}_11",
        "text-anchor": "left",
        "text-field": "{name_en}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-max-width": 9,
        "text-offset": [0.9, 0],
        "text-size": 12
      },
      "paint": {
        "text-color": "#4898ff",
        "text-halo-blur": 0.5,
        "text-halo-color": "#ffffff",
        "text-halo-width": 1
      }
    },
    {
      "id": "road_label",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "transportation_name",
      "filter": ["all"],
      "layout": {
        "symbol-placement": "line",
        "text-anchor": "center",
        "text-field": "{name}",
        "text-font": ["Open Sans Regular"],
        "text-offset": [0, 0.15],
        "text-size": {"base": 1, "stops": [[13, 12], [14, 13]]}
      },
      "paint": {
        "text-color": "#765",
        "text-halo-blur": 0.5,
        "text-halo-width": 1
      }
    },
    {
      "id": "road_shield",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "transportation_name",
      "minzoom": 7,
      "filter": ["all", ["<=", "ref_length", 6]],
      "layout": {
        "icon-image": "default_{ref_length}",
        "icon-rotation-alignment": "viewport",
        "symbol-placement": {"base": 1, "stops": [[10, "point"], [11, "line"]]},
        "symbol-spacing": 500,
        "text-field": "{ref}",
        "text-font": ["Open Sans Regular"],
        "text-offset": [0, 0.1],
        "text-rotation-alignment": "viewport",
        "text-size": 10,
        "icon-size": 0.8
      }
    },
    {
      "id": "place_other",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "filter": [
        "all",
        ["in", "class", "hamlet", "island", "islet", "neighbourhood", "suburb"]
      ],
      "layout": {
        "text-field": "{name_en}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-letter-spacing": 0.1,
        "text-max-width": 9,
        "text-size": {"base": 1.2, "stops": [[12, 10], [15, 14]]},
        "text-transform": "uppercase"
      },
      "paint": {
        "text-color": "#633",
        "text-halo-color": "rgba(255,255,255,0.8)",
        "text-halo-width": 1.2
      }
    },
    {
      "id": "place_village",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "filter": ["all", ["==", "class", "village"]],
      "layout": {
        "text-field": "{name_en}",
        "text-font": ["Open Sans Regular"],
        "text-max-width": 8,
        "text-size": {"base": 1.2, "stops": [[10, 12], [15, 22]]}
      },
      "paint": {
        "text-color": "#333",
        "text-halo-color": "rgba(255,255,255,0.8)",
        "text-halo-width": 1.2
      }
    },
    {
      "id": "place_town",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "filter": ["all", ["==", "class", "town"]],
      "layout": {
        "icon-image": {"base": 1, "stops": [[0, "dot_9"], [8, ""]]},
        "text-anchor": "bottom",
        "text-field": "{name_en}",
        "text-font": ["Open Sans Regular"],
        "text-max-width": 8,
        "text-offset": [0, 0],
        "text-size": {"base": 1.2, "stops": [[7, 12], [11, 16]]}
      },
      "paint": {
        "text-color": "#333",
        "text-halo-color": "rgba(255,255,255,0.8)",
        "text-halo-width": 1.2
      }
    },
    {
      "id": "place_city",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "minzoom": 5,
      "filter": ["all", ["==", "class", "city"]],
      "layout": {
        "icon-image": {"base": 1, "stops": [[0, "dot_9"], [8, ""]]},
        "text-anchor": "bottom",
        "text-field": "{name_en}",
        "text-font": ["Metropolis Medium"],
        "text-max-width": 8,
        "text-offset": [0, 0],
        "text-size": {"base": 1.2, "stops": [[7, 14], [11, 24]]},
        "icon-allow-overlap": true,
        "icon-optional": false
      },
      "paint": {
        "text-color": "#333",
        "text-halo-color": "rgba(255,255,255,0.8)",
        "text-halo-width": 1.2
      }
    },
    {
      "id": "state",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "maxzoom": 6,
      "filter": ["all", ["==", "class", "state"]],
      "layout": {
        "text-field": "{name_en}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-size": {"stops": [[4, 11], [6, 15]]},
        "text-transform": "uppercase"
      },
      "paint": {
        "text-color": "#633",
        "text-halo-color": "rgba(255,255,255,0.7)",
        "text-halo-width": 1
      }
    },
    {
      "id": "country_3",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "filter": ["all", [">=", "rank", 3], ["==", "class", "country"]],
      "layout": {
        "text-field": "{name_en}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-max-width": 6.25,
        "text-size": {"stops": [[3, 11], [7, 17]]},
        "text-transform": "none"
      },
      "paint": {
        "text-color": "#334",
        "text-halo-blur": 1,
        "text-halo-color": "rgba(255,255,255,0.8)",
        "text-halo-width": 1
      }
    },
    {
      "id": "country_2",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "filter": ["all", ["==", "rank", 2], ["==", "class", "country"]],
      "layout": {
        "text-field": "{name_en}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-max-width": 6.25,
        "text-size": {"stops": [[2, 11], [5, 17]]},
        "text-transform": "none"
      },
      "paint": {
        "text-color": "#334",
        "text-halo-blur": 1,
        "text-halo-color": "rgba(255,255,255,0.8)",
        "text-halo-width": 1
      }
    },
    {
      "id": "country_1",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "filter": ["all", ["==", "rank", 1], ["==", "class", "country"]],
      "layout": {
        "text-field": "{name_en}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-max-width": 6.25,
        "text-size": {"stops": [[1, 11], [4, 17]]},
        "text-transform": "none"
      },
      "paint": {
        "text-color": "#334",
        "text-halo-blur": 1,
        "text-halo-color": "rgba(255,255,255,0.8)",
        "text-halo-width": 1
      }
    },
    {
      "id": "continent",
      "type": "symbol",
      "source": "openmaptiles",
      "source-layer": "place",
      "maxzoom": 1,
      "filter": ["all", ["==", "class", "continent"]],
      "layout": {
        "text-field": "{name_en}",
        "text-font": ["Open Sans Semibold Italic"],
        "text-size": 13,
        "text-transform": "uppercase",
        "text-justify": "center"
      },
      "paint": {
        "text-color": "#633",
        "text-halo-color": "rgba(255,255,255,0.7)",
        "text-halo-width": 1
      }
    }
  ],
  "id": "osm-liberty"
}
;
    return ThemeReader().read(data);
    // maps are rendered using themes
    // to provide a dark theme do something like this:
    // if (MediaQuery.of(context).platformBrightness == Brightness.dark) return myDarkTheme();
    // return ProvidedThemes.lightTheme();
    // return ThemeReader(logger: const Logger.console())
    //     .read(myCustomStyle());
  }

  _backgroundTheme() {
    return _mapTheme()
        .copyWith(types: {ThemeLayerType.background, ThemeLayerType.fill});
  }

  String _urlTemplate() {
    const mapboxApiKey="pk.eyJ1Ijoic2t5d2llIiwiYSI6ImNrcHc0MWkyeTB1YWIydW9qcnl5c2F4bnQifQ.LLEW7NutjcTTyxzzxrRFJQ";
    // IMPORTANT: See readme about matching tile provider with theme

    // Stadia Maps source https://docs.stadiamaps.com/vector/
    // ignore: undefined_identifier
    // return 'https://tiles.stadiamaps.com/data/openmaptiles/{z}/{x}/{y}.pbf?api_key=$stadiaMapsApiKey';

    // Maptiler source
    // return 'https://api.maptiler.com/tiles/v3/{z}/{x}/{y}.pbf?key=$maptilerApiKey';

    // Mapbox source https://docs.mapbox.com/api/maps/vector-tiles/#example-request-retrieve-vector-tiles
    return 'https://api.mapbox.com/v4/mapbox.mapbox-streets-v8/{z}/{x}/{y}.mvt?access_token=$mapboxApiKey';
  }

  Widget _statusText() => Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: StreamBuilder(
          stream: _controller.mapEventStream,
          builder: (context, snapshot) {
            return Text(
                'Zoom: ${_controller.zoom.toStringAsFixed(2)} Center: ${_controller.center.latitude.toStringAsFixed(4)},${_controller.center.longitude.toStringAsFixed(4)}');
          }));
}
