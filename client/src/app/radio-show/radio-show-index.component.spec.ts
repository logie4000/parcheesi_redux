import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RadioShowIndexComponent } from './radio-show-index.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';

describe('RadioShowIndexComponent', () => {
  let component: RadioShowIndexComponent;
  let fixture: ComponentFixture<RadioShowIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
      ],      
      imports: [RadioShowIndexComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RadioShowIndexComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
