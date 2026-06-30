import { fakeAsync, inject, TestBed, tick } from '@angular/core/testing';

import { AlbumService } from './album.service';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';

import * as config from '../app.config';
import * as testData from '../test/test-data'
import { Album } from '../models/album';

describe('AlbumService', () => {
  const model: Album = testData.ALBUM_1;

  let service: AlbumService;
  let httpTestingController: HttpTestingController;
  
  beforeEach(() => {
    TestBed.configureTestingModule({      
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
    ]});
    service = TestBed.inject(AlbumService);
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

    mockHttp.expectOne(`${config.DB_ALBUM_SERVICE}/${model.id}`).flush(model)
    tick();
    mockHttp.verify();
  })));

  it('should return the item URL', () => {
      expect(service.itemUrl(model)).toEqual(`${config.HOST_ALBUM_SERVICE}/${model.id}`)
  });
});
