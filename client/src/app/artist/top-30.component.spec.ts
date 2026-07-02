import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Top30Component } from './top-30.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';

describe('Top30Component', () => {
  let component: Top30Component;
  let fixture: ComponentFixture<Top30Component>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
      ],      
      imports: [Top30Component]
    })
    .compileComponents();

    fixture = TestBed.createComponent(Top30Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
