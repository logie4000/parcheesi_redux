import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeeJayListComponent } from './dee-jay-list.component';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';

describe('DeeJayListComponent', () => {
  let component: DeeJayListComponent;
  let fixture: ComponentFixture<DeeJayListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
      ],      
      imports: [DeeJayListComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DeeJayListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
