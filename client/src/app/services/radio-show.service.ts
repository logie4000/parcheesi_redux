import { Injectable } from '@angular/core';
import { RadioShow } from '../models/radio-show';

import * as config from '../app.config';
import { ModelService } from './model.service';

@Injectable({
  providedIn: 'root'
})
export class RadioShowService extends ModelService<RadioShow> {
  override endpointUrl: string = config.DB_RADIO_SHOW_SERVICE;
  override api: string = config.HOST_RADIO_SHOW_SERVICE;

  override itemUrl(radio_show: RadioShow): string {
    return `${config.HOST_RADIO_SHOW_SERVICE}/${radio_show.id}`
  }
}
