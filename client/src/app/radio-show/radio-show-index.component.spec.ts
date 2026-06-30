import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RadioShowIndexComponent } from './radio-show-index.component';

describe('RadioShowIndexComponent', () => {
  let component: RadioShowIndexComponent;
  let fixture: ComponentFixture<RadioShowIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
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
