

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {

  static Actor castToEntity( Cast cast  ) => Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null
    ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
    : 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKwAAACUCAMAAAA5xjIqAAAANlBMVEWzs7P///+rq6vp6emvr6+5ubnw8PDR0dG2trb8/Pz29vbOzs7d3d3t7e29vb3m5ubGxsbX19fHFlU5AAADSUlEQVR4nO2cC5arIAxAEaOCIsj+NzvYTmf6cSqESvC93BXck8bwSagQDMMwDMMwhyEDQC0RCbh+bs1kO3UG4+bK6PwiaveVzQ/j7CvXhbm5Q5uual3fPGJqzoblSbbRzkpqqT+AF9k1GWoMLnSL0a+yQXeiVnsGrBm3TC84W1NwQbm/VdfgLtVkLnTPVeAVo6gtr8DU77o2TV9FKsD2Z/XCWIGtaqNUm7UqUNuqed+yGlsX77oWBVJbk+JKm7cwpbk2zUxYweLqwD0DlapMTIIVTSVr0wMb9gk0Cy8gAhtCS5O1Xcwq+4onKQjJpeDKTOGaWmNvjJZCNmGhfYBi0VWYWrDiy7uKDunaOAJZi5Wl+MLQsj1BpT2V7MaFxj8oS7FN/E9ky7viZVsCWXQ1OJWsO1OdZdkd0BsZU95VKJY9Sha7+SaQBTjPSQEs9ggWTgqFD2EwYeO6Uvjm075tzuyhi57GYb8985aitzIyK7BhL1NyEZP7Pm8puv/OlS0bWdwF4g9F1wXc1ewvQ9HahT7TXCh8kdjlrAnNXHgJyyq0pbthOUtYX7oHkvOJlW+KAjq0FPtZ7IGRpKeATYSyNfYG7hsrXba+Se+JB3RH4vo8JxmHIRs4SL/n6Ek6dhfSDwyUUzKpvWair+tK6iGX6uu6IpOmjygaoQ8khLanDWxasaWeQRMJY2iO3jV61dUVuEYnQgVJIGK3X3Tr7BMRU6kUExHb7KftWMkUtYgYoiWeRb0Hlp2VoSLX/QkvmlGubdRuytbzecVcfA21PKqIugavJGu3niq9UsMrhfWtStxpoQZbsLEnG03+SBCW+FPYSLuVgdh3Nd+x9WQ1AUSX3BPtaR5gAliDadm48rogpxZ5P6tnL8q9JwehbGZnqR+sEsdHOPz605uXlfGMzk+2AzjMGKT17x9WJgr3zi9KHlIiFjNmdb820Xo0yyctAdQyuc+L/tIO9jMpLENI2yNNL4xuytYNaXrEj7+FDstxhm749X0Z0ZvvgP1/DBDDoXm6yYzb7EifOQCBQ7eI5S1vFipLN/kfBlLe/n6a5N4u8hXdR0jul7Isy7Isy7Isy7Isy7Isy55a1rRkpDd2QJJB3XpgGIZhGOYkfAEHATJkX2X/NwAAAABJRU5ErkJggg==',
    character: cast.character,
  );
}