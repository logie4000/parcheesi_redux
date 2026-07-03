import { TestBed } from '@angular/core/testing';

import { Top30Service } from './top-30.service';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';

describe('Top30Service', () => {
  let service: Top30Service;
  
  let httpTestingController: HttpTestingController;
  
  beforeEach(() => {
    TestBed.configureTestingModule({      
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
    ]});
    service = TestBed.inject(Top30Service);
    httpTestingController = TestBed.inject(HttpTestingController);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
    
  // it('should fetch model data', fakeAsync(inject([HttpTestingController], (mockHttp: HttpTestingController) => {
  //   var modelItem = service.fetchData(model.id);
    
  //   modelItem.subscribe((s) => {
  //     expect(s).withContext("service returned stub value").toEqual(model);
  //   });

  //   mockHttp.expectOne(`${config.DB_ARTIST_SERVICE}/${model.id}`).flush(model)
  //   tick();
  //   mockHttp.verify();
  // })));

  // it('should return the item URL', () => {
  //     expect(service.itemUrl(model)).toEqual(`${config.HOST_ARTIST_SERVICE}/${model.id}`)
  // });
});
