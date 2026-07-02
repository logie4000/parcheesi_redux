import { ApplicationConfig } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { APP_BASE_HREF, PlatformLocation } from '@angular/common';
import { provideHttpClient } from '@angular/common/http';

export const APP_TITLE = "Parcheesi Redux";
export const REST_DB_PATH = 'https://www.teapothill.org/parcheesi-redux/api';

export const HOST_ARTIST_SERVICE = 'artists';
export const HOST_ALBUM_SERVICE = 'albums';
export const HOST_DEEJAY_SERVICE = 'dee_jays';
export const HOST_RADIO_SHOW_SERVICE = 'radio_shows';
export const HOST_SONG_SERVICE = 'songs';
export const HOST_TOP30_SERVICE = 'top_30';

export const DB_ARTIST_SERVICE = `${REST_DB_PATH}/${HOST_ARTIST_SERVICE}`;
export const DB_ALBUM_SERVICE = `${REST_DB_PATH}/${HOST_ALBUM_SERVICE}`;
export const DB_DEEJAY_SERVICE = `${REST_DB_PATH}/${HOST_DEEJAY_SERVICE}`;
export const DB_RADIO_SHOW_SERVICE = `${REST_DB_PATH}/${HOST_RADIO_SHOW_SERVICE}`;
export const DB_SONG_SERVICE = `${REST_DB_PATH}/${HOST_SONG_SERVICE}`;
export const DB_TOP30_SERVICE = `${REST_DB_PATH}/${HOST_TOP30_SERVICE}`;

export function getBaseHref(platformLocation: PlatformLocation) {
  return platformLocation.getBaseHrefFromDOM();
}

export const appConfig: ApplicationConfig = {
  providers: [provideRouter(routes),
    provideHttpClient(),
    {
      provide: APP_BASE_HREF,
      useFactory: getBaseHref,
      deps: [PlatformLocation],
    }
  ]
};
