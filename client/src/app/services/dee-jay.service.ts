import { Injectable } from '@angular/core';
import { ModelService } from './model.service';
import { DeeJay } from '../models/dee-jay';

import * as config from '../app.config';

@Injectable({
  providedIn: 'root'
})
export class DeeJayService extends ModelService<DeeJay> {
  override endpointUrl: string = config.DB_DEEJAY_SERVICE;
  override api: string = config.HOST_DEEJAY_SERVICE;

  override itemUrl(dee_jay: DeeJay): string {
    return `${config.HOST_DEEJAY_SERVICE}/${dee_jay.id}`
  }
}
