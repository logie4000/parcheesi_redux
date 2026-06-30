import { TestBed } from '@angular/core/testing';

import { DeeJayService } from './dee-jay.service';

describe('DeeJayService', () => {
  let service: DeeJayService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DeeJayService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
