import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeeJayListComponent } from './dee-jay-list.component';

describe('DeeJayListComponent', () => {
  let component: DeeJayListComponent;
  let fixture: ComponentFixture<DeeJayListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
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
