import 'package:hydrosmart/features/soil/domain/video.dart';

Map<String, Map<String, dynamic>> HUMIDITY_SUGGESTIONS = {
  'FAVORABLE': {
    'id': 1,
    'title': "Favorable",
    'message': "La humedad es adecuada para el cultivo. No se requiere acción.",
    'videos': <Video>[],
  },
  'SLIGHTLY_UNFAVORABLE_UNDER': {
    'id': 2,
    'title': "Levemente baja",
    'message': "Humedad levemente por debajo de lo adecuado. Se recomienda aumentar la frecuencia de riego.",
    'videos': <Video>[
      Video(
        title: "Importancia de la humedad relativa en el cultivo",
        url: "https://youtu.be/m8XQSnRb0_4?si=jJaBR_yJ8EDvHM6J",
      ),
    ],
  },
  'SLIGHTLY_UNFAVORABLE_OVER': {
    'id': 3,
    'title': "Levemente alta",
    'message': "Humedad levemente por encima de lo adecuado. Se recomienda reducir la frecuencia de riego.",
    'videos': <Video>[
      Video(
        title: "Importancia de la humedad relativa en el cultivo",
        url: "https://youtu.be/m8XQSnRb0_4?si=jJaBR_yJ8EDvHM6J",
      ),
    ],
  },
  'UNFAVORABLE_UNDER': {
    'id': 4,
    'title': "Baja",
    'message': "Humedad por debajo de lo adecuado. Se sugiere aumentar considerablemente la frecuencia de riego.",
    'videos': <Video>[
      Video(title: "Manejo de Humedad en Suelos", url: "https://youtu.be/UUTGTzz47fg?si=1eFpuqBCxhZ38SR8"),
      Video(title: "Consejos para controlar la humedad en tus cultivos #bordergrower", url: "https://youtu.be/cl11xITdALc?si=T7v_0_G3Zqrpc0Rg"),
    ],
  },
  'UNFAVORABLE_OVER': {
    'id': 5,
    'title': "Alta",
    'message': "Humedad por encima de lo adecuado. Se sugiere reducir considerablemente la frecuencia de riego.",
    'videos': <Video>[
      Video(title: "ASÍ bajo la humedad sin subir la temperatura en el TROPICAL", url: "https://youtu.be/RWw1ChwrpHw?si=_k2eWHZ1aOnfmSy7"),
      Video(title: "Efectos del Exceso de Humedad del Suelo", url: "https://youtu.be/pnkXkU8KcmM?si=-mUDGcBw1TXpMF-D"),
    ],
  },
  'FLOODED': {
    'id': 6,
    'title': "Inundado",
    'message': "El suelo está inundado. Se requiere atención manual para eliminar el exceso de agua.",
    'videos': <Video>[
      Video(title: "Cómo evitar daños a cultivos, en caso de inundaciones", url: "https://youtu.be/RJJi2dr-SUs?si=6SrHFm6RvSgh7dWY"),
      Video(title: "Recuperar Cultivo Después De inundación.", url: "https://youtu.be/sPniCUueBU0?si=5YTWXn6eSv2U1ioc"),
      Video(title: "Se inundó el cultivo. Mejora tu estructura de siembra.", url: "https://youtube.com/shorts/zwbtHpRDjK4?si=nc2_wgiiOj3kXuZd"),
    ],
  },
  'DRY': {
    'id': 7,
    'title': "Seco",
    'message': "El suelo está seco. Se requiere regar inmediatamente para no perder los cultivos.",
    'videos': <Video>[
      Video(title: "Cómo recuperar TIERRA SECA", url: "https://youtu.be/opweG43YSAY?si=xBkkzJ0YPmau2dMt"),
      Video(title: "REVIVE cualquier PLANTA con este ABONO CASERO ! Curar plantas ENFERMAS o SECAS", url: "https://youtu.be/xHXnR6PFrKg?si=_VhzMGgIQYIhnw1K"),
      Video(title: "Revive tus plantas enfermas o secas con esto ", url: "https://youtube.com/shorts/D5ul-GVbmnM?si=KUIClUUphoExJ8tN"),
    ],
  },
};
