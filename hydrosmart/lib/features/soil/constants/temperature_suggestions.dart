import 'package:hydrosmart/features/soil/domain/video.dart';

Map<String, Map<String, dynamic>> TEMPERATURE_SUGGESTIONS = {
  'FAVORABLE': {
    'id': 1,
    'title': "Favorable",
    'message': "La temperatura es adecuada para el cultivo. No se requiere acción.",
    'videos': <Video>[],
  },
  'SLIGHTLY_UNFAVORABLE_UNDER': {
    'id': 2,
    'title': "Levemente baja",
    'message': "Temperatura ligeramente por debajo de lo adecuado. Se recomienda exponer los cultivos más al sol.",
    'videos': <Video>[
      Video(title: "Cómo Controlar la Temperatura para Cultivo",
      url: "https://youtu.be/ZvlHhkS9wtM?si=tcpOLUc3dv7kjo9s"),
    ],
  },
  'SLIGHTLY_UNFAVORABLE_OVER': {
    'id': 3,
    'title': "Levemente alta",
    'message': "Temperatura ligeramente por encima de lo adecuado. Se recomienda agregar más sombra a los cultivos.",
    'videos': <Video>[
      Video(title: "Cómo Controlar la Temperatura para Cultivo",
      url: "https://youtu.be/ZvlHhkS9wtM?si=tcpOLUc3dv7kjo9s"),
    ],
  },
  'UNFAVORABLE_UNDER': {
    'id': 4,
    'title': "Baja",
    'message': "Temperatura por debajo de lo adecuado. Se recomienda exponer los cultivos más al sol y verificar la frecuencia del regado.",
    'videos': <Video>[
      Video(title: "Cuidado con las temperaturas bajas. Haz esto!", url: "https://youtube.com/shorts/tzFo1Fp5huE?si=FZHNvMHePG8jb2Jy"),
      Video(title: "Salvar los cultivos del frío", url: "https://youtu.be/BH4yt6t6gh8?si=DxfMZMKkOAkox77u"),
    ],
  },
  'UNFAVORABLE_OVER': {
    'id': 5,
    'title': "Alta",
    'message': "Temperatura por encima de lo adecuado. Se recomienda agregar más sombra a los cultivos y aumentar ligeramente la frecuencia de regado.",
    'videos': <Video>[
      Video(title: "Cómo instalar malla sombra para proteger tus cultivos y plantas", url: "https://youtu.be/3iXUS811zEs"),
      Video(title: "Manejo de cultivos en verano", url: "https://youtu.be/NDA81U7oBfk?si=zv4tcqXzBWxyCt_l"),
      Video(title: "Uso de sombra para proteger del calor", url: "https://youtu.be/27mQQ1RhWDE"),
    ],
  },
  'BURNING': {
    'id': 6,
    'title': "Muy alta (riesgo de incendio)",
    'message': "El suelo está en llamas. Mantenga la calma e intente apagar el fuego. Es posible que los cultivos se hayan perdido.",
    'videos': <Video>[
      Video(title: "#ConQuitoTips: ¿Qué hacer con los cultivos durante los incendios?", url: "https://youtube.com/shorts/-JK3s4u7RhM?si=l0HoAHlA8wwO369H"),
      Video(title: "Cortafuegos y riesgos de incendios", url: "https://youtube.com/shorts/dqNYh1vSHN4?si=9t_vJIOFdNWgwV0U"),
      Video(title: "Acumulación térmica de los cultivos (Grados Dias) | ViLab", url: "https://youtu.be/bsnMqps3xvk?si=-hQkzln7W09FCrFf"),
    ],
  },
  'FREEZING': {
    'id': 7,
    'title': "Muy baja (riesgo de congelación)",
    'message': "El suelo está muy por debajo de lo adecuado. Intente exponer los cultivos más al sol y regar con agua tibia para nivelar la temperatura.",
    'videos': <Video>[
      Video(title: "Condiciones del clima en BAJAS TEMPERATURAS (Heladas, Niebla, humedad relativa)", url: "https://youtu.be/m8nOYBGoDOk?si=zIbyiB-RI3CtFzwO"),
      Video(title: "Proteja sus cultivos de las bajas temperaturas o heladas", url: "https://youtu.be/m5su18GKJSI?si=dYRmZpUfA9Iri2Oq"),
      Video(title: "¡No dejes que la helada afecte tus cultivos! ColdKiller No más miedo a las heladas.", url: "https://youtube.com/shorts/wfsUT8dKEmg?si=AYpoZsytV5HnDvhJ"),
    ],
  },
};
