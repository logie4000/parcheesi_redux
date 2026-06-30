import { fakeAsync, inject, TestBed, tick } from '@angular/core/testing';

import { DeeJayService } from './dee-jay.service';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';

import * as config from '../app.config';
import * as testData from '../test/test-data'
import { DeeJay } from '../models/dee-jay';

describe('DeeJayService', () => {
  const model: DeeJay = testData.DEE_JAY_1;

  let service: DeeJayService;
  let httpTestingController: HttpTestingController;
  
  beforeEach(() => {
    TestBed.configureTestingModule({      
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
    ]});
    service = TestBed.inject(DeeJayService);
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

    mockHttp.expectOne(`${config.DB_DEEJAY_SERVICE}/${model.id}`).flush(model)
    tick();
    mockHttp.verify();
  })));

  it('should return the item URL', () => {
      expect(service.itemUrl(model)).toEqual(`${config.HOST_DEEJAY_SERVICE}/${model.id}`)
  });
});
