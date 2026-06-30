import { fakeAsync, inject, TestBed, tick } from '@angular/core/testing';

import { SongService } from './song.service';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';

import * as config from '../app.config';
import * as testData from '../test/test-data'
import { Song } from '../models/song';

describe('SongService', () => {
  let service: SongService;
  let httpTestingController: HttpTestingController;
  
  beforeEach(() => {
    TestBed.configureTestingModule({      
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
    ]});
    service = TestBed.inject(SongService);
    httpTestingController = TestBed.inject(HttpTestingController);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
  
  it('should fetch model data', fakeAsync(inject([HttpTestingController], (mockHttp: HttpTestingController) => {
    const model: Song = testData.SONG_1;

    var modelItem = service.fetchData(model.id);
    
    modelItem.subscribe((s) => {
      expect(s).withContext("service returned stub value").toEqual(model);
    });

    mockHttp.expectOne(`${config.DB_SONG_SERVICE}/${model.id}`).flush(model)
    tick();
    mockHttp.verify();
  })));

  it('should return the item URL', () => {
      expect(service.itemUrl(testData.SONG_1)).toEqual(`${config.HOST_SONG_SERVICE}/${testData.SONG_1.id}`)
  });
});
