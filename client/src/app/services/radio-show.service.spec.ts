import { TestBed } from '@angular/core/testing';

import { RadioShowService } from './radio-show.service';

describe('RadioShowService', () => {
  let service: RadioShowService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(RadioShowService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
