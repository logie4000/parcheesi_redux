import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RadioShowListComponent } from './radio-show-list.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';

describe('RadioShowListComponent', () => {
  let component: RadioShowListComponent;
  let fixture: ComponentFixture<RadioShowListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
      ],      
      imports: [RadioShowListComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RadioShowListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
