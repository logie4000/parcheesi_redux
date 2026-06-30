import { ApplicationConfig } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { APP_BASE_HREF, PlatformLocation } from '@angular/common';
import { provideHttpClient } from '@angular/common/http';

export const APP_TITLE = "Parcheesi Redux";
export const REST_DB_PATH = 'https://www.teapothill.org/parcheesi-redux/api';

export const HOST_ARTIST_SERVICE = 'artists';

export const DB_ARTIST_SERVICE = `${REST_DB_PATH}/${HOST_ARTIST_SERVICE}`;

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
