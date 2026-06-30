import { fakeAsync, inject, TestBed, tick } from '@angular/core/testing';

import { RadioShowService } from './radio-show.service';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';

import * as config from '../app.config';
import * as testData from '../test/test-data'
import { RadioShow } from '../models/radio-show';

describe('RadioShowService', () => {
  const model: RadioShow = testData.RADIO_SHOW_1;

  let service: RadioShowService;
  let httpTestingController: HttpTestingController;
  
  beforeEach(() => {
    TestBed.configureTestingModule({      
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
    ]});
    service = TestBed.inject(RadioShowService);
    httpTestingController = TestBed.inject(HttpTestingController);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should fetch model data', fakeAsync(inject([HttpTestingController], (mockHttp: HttpTestingController) => {
    var modelItem = service.fetchData(model.id);
    
    modelItem.subscribe((s) => {
      expect(s).withContext("service returned stub value").toEqual(model);
    });

    mockHttp.expectOne(`${config.DB_RADIO_SHOW_SERVICE}/${model.id}`).flush(model)
    tick();
    mockHttp.verify();
  })));

  it('should return the item URL', () => {
      expect(service.itemUrl(model)).toEqual(`${config.HOST_RADIO_SHOW_SERVICE}/${model.id}`)
  });
});
