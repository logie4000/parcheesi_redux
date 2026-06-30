import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeeJayIndexComponent } from './dee-jay-index.component';

describe('DeeJayIndexComponent', () => {
  let component: DeeJayIndexComponent;
  let fixture: ComponentFixture<DeeJayIndexComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DeeJayIndexComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DeeJayIndexComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
